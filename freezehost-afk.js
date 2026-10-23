// ==UserScript==
// @name         FreezeHost Auto AFK + Ads + Panel
// @namespace    http://tampermonkey.net/
// @version      4.1
// @description  Auto Start Earning, giữ Hold to Start, xem quảng cáo thưởng, bảng thống kê kéo thả (Alt+Z), delay ngẫu nhiên, chống lặp vô tận, theo dõi Daily Reset và tự xóa thống kê khi reset. Chỉ chạy ở chế độ desktop.
// @match        https://free.freezehost.pro/*
// @run-at       document-idle
// @grant        none
// ==/UserScript==

(function () {
  'use strict';

  if (window.__fhAfkLoaded) return;
  window.__fhAfkLoaded = true;

  // ---------- Chỉ chạy ở chế độ desktop ----------
  const uaMobile = /Mobi|Android|iPhone|iPad|iPod/i.test(navigator.userAgent);
  const wide = Math.max(window.innerWidth, document.documentElement.clientWidth) >= 1000;
  if (uaMobile && !wide) {
    console.log('[FH-AFK] Đang ở chế độ mobile, script không chạy. Hãy bật "Trang web cho máy tính".');
    return;
  }

  const CFG = {
    holdMinMs: 3300, holdMaxMs: 5200,         // thời gian giữ nút (ngẫu nhiên)
    cfDelayMin: 2500, cfDelayMax: 7000,       // delay sau khi Cloudflare báo thành công
    coinsDelayMin: 1500, coinsDelayMax: 4500, // delay trước khi bấm Start Earning
    graceMs: 8000,                            // chờ /earn load xong
    adGraceMs: 10000,                         // không bấm quảng cáo trong N ms đầu của /earn
    turnstileWaitMs: 120000,
    sessionMaxMs: 21 * 60 * 1000,
    loopWindowMs: 4 * 60 * 1000,              // cửa sổ phát hiện lặp
    loopMax: 4,                               // số lần về /coins bất thường trong cửa sổ => tự dừng
    resetJumpMs: 10 * 60 * 1000,              // mốc reset nhảy tới trước >10 phút => đã reset
    resetStaleMs: 20 * 1000,                  // quá mốc reset >20s mà không thấy đồng hồ => đã reset
    tick: 1500,
    hideAds: true,                            // đặt false nếu quảng cáo thưởng không hoàn thành được
    maxLog: 60,
  };

  const now = () => Date.now();
  const rnd = (a, b) => a + Math.random() * (b - a);
  const route = () => {
    const p = location.pathname;
    return p.startsWith('/earn') ? 'earn' : p.startsWith('/coins') ? 'coins' : 'other';
  };

  // ---------- Lưu trữ ----------
  const ss = {
    get: k => sessionStorage.getItem(k),
    set: (k, v) => sessionStorage.setItem(k, v),
    del: k => sessionStorage.removeItem(k),
  };
  const LS = {
    get(k, d) { try { const v = localStorage.getItem(k); return v === null ? d : JSON.parse(v); } catch (e) { return d; } },
    set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} },
  };

  const ZERO_STATS = { totalCoins: 0, totalAfkMs: 0, sessions: 0, ads: 0 };
  const stats = Object.assign({}, ZERO_STATS, LS.get('fh_stats', {}));
  const ui = Object.assign({ x: 20, y: 80, visible: true, paused: false }, LS.get('fh_ui', {}));
  let logs = LS.get('fh_log', []);
  let logVer = 0;
  let status = 'Khởi động...';
  let limitStopped = false;

  const saveStats = () => LS.set('fh_stats', stats);
  const saveUI = () => LS.set('fh_ui', ui);

  function log(msg) {
    const t = new Date().toTimeString().slice(0, 8);
    logs.push(`${t} ${msg}`);
    if (logs.length > CFG.maxLog) logs = logs.slice(-CFG.maxLog);
    LS.set('fh_log', logs);
    logVer++;
    console.log('[FH-AFK]', msg);
  }

  function fmt(ms) {
    const s = Math.max(0, Math.floor(ms / 1000));
    const h = Math.floor(s / 3600), m = Math.floor((s % 3600) / 60), x = s % 60;
    return `${h}:${String(m).padStart(2, '0')}:${String(x).padStart(2, '0')}`;
  }
  function fmtHMS(ms) {
    const s = Math.max(0, Math.floor(ms / 1000));
    const h = Math.floor(s / 3600), m = Math.floor((s % 3600) / 60), x = s % 60;
    const p = n => String(n).padStart(2, '0');
    return `${p(h)}h ${p(m)}m ${p(x)}s`;
  }

  // ---------- Tiện ích DOM ----------
  // Popup nằm trong Shadow DOM nên querySelector / innerText của trang không thấy nó.
  function isVisible(el) {
    const r = el.getBoundingClientRect();
    const s = getComputedStyle(el);
    return r.width > 0 && r.height > 0 && s.display !== 'none' && s.visibility !== 'hidden';
  }

  // Tìm phần tử nhỏ nhất đang hiển thị có chữ khớp regex (chữ ngắn, tránh khớp nhầm tiêu đề dài)
  function findByText(regex, maxLen = 30, selector = 'a, button, [role="button"], div, span') {
    let best = null;
    document.querySelectorAll(selector).forEach(el => {
      const t = (el.textContent || '').trim();
      if (!t || t.length > maxLen || !regex.test(t) || !isVisible(el)) return;
      if (!best || t.length < best.textContent.trim().length) best = el;
    });
    return best;
  }
  const clickable = el => el && (el.closest('button, a, [role="button"]') || el);

  // ---------- Ẩn quảng cáo bằng CSS ----------
  if (CFG.hideAds) {
    const style = document.createElement('style');
    style.textContent = `
      ins.adsbygoogle, iframe[id^="google_ads"], iframe[src*="googlesyndication"],
      iframe[src*="doubleclick"], [id^="aswift_"], .google-auto-placed,
      .google-anchor-container, [class*="anchor-ad" i], div[id^="div-gpt-ad"] { display: none !important; }
      html, body { overflow: auto !important; }
    `;
    document.documentElement.appendChild(style);
  }

  function closePopups() {
    if (route() !== 'coins') return;
    const sel = '.modal-close, .btn-close, .popup-close, button[aria-label*="close" i]';
    document.querySelectorAll(sel).forEach(el => {
      if (!isVisible(el)) return;
      if (el.closest('a[href], nav, header, aside, [role="navigation"]') || el.tagName === 'A') return;
      const t = (el.textContent || '').toLowerCase();
      if (/claim|start|hold|earn|dashboard/.test(t)) return;
      let n = el, overlay = false;
      while (n && n !== document.body) {
        const s = getComputedStyle(n);
        if (s.position === 'fixed' && (parseInt(s.zIndex, 10) || 0) >= 100) { overlay = true; break; }
        n = n.parentElement;
      }
      if (overlay) { log('Đóng popup'); el.click(); }
    });
  }

  // ---------- Xem quảng cáo thưởng (tắt tiếng) ----------
  const clickedAds = new WeakSet();
  function clickByText(patterns) {
    const nodes = document.querySelectorAll('button, [role="button"], a, div[tabindex]');
    for (const el of nodes) {
      if (clickedAds.has(el) || !isVisible(el)) continue;
      // Không bấm link điều hướng / menu
      if (el.closest('nav, header, aside, footer, [role="navigation"], [role="menu"]')) continue;
      if (el.tagName === 'A') {
        const h = (el.getAttribute('href') || '').trim();
        if (h && h !== '#' && !h.startsWith('javascript')) continue;
      }
      const t = (el.innerText || el.getAttribute('aria-label') || '').trim().toLowerCase();
      if (!t || t.length > 25) continue;
      if (patterns.some(p => t.includes(p))) {
        clickedAds.add(el);
        ss.set('fh_last_click', JSON.stringify({ t, at: now() }));
        log(`Bấm "${t}" <${el.tagName.toLowerCase()} class="${String(el.className).slice(0, 40)}">`);
        el.click();
        return t;
      }
    }
    return null;
  }

  function adLoop() {
    if (!ui.paused) {
      document.querySelectorAll('video').forEach(v => { v.muted = true; });
      const pageAt = +ss.get('fh_page_at') || 0;
      const settled = route() !== 'earn' || (pageAt && now() - pageAt > CFG.adGraceMs);
      if (settled) {
        const a = clickByText(['view a short ad', 'watch ad']);
        if (a) { stats.ads++; saveStats(); }
        clickByText(['claim', 'close ad', 'continue to site']);
      }
    }
    setTimeout(adLoop, rnd(900, 2200));
  }

  // ---------- Đọc thông tin trang ----------
  function parseRemainingSec() {
    const m = document.body.innerText.match(/SESSION\s*REMAINING[\s\S]{0,40}?(\d{1,2}):(\d{2})/i);
    return m ? parseInt(m[1], 10) * 60 + parseInt(m[2], 10) : null;
  }
  function parseDaily() {
    const m = document.body.innerText.match(/(\d+)\s*\/\s*(\d+)\s*COINS\s*TODAY/i);
    return m ? { cur: parseInt(m[1], 10), max: parseInt(m[2], 10) } : null;
  }
  const dailyLimitReached = () => { const d = parseDaily(); return !!(d && d.cur >= d.max); };

  // Đọc toàn bộ thông số hiển thị trên trang (một lần mỗi giây, dùng cho bảng + Daily Reset)
  function readPage() {
    const txt = (document.body && document.body.innerText) || '';
    const num = (re) => { const m = txt.match(re); return m ? parseInt(m[1], 10) : null; };
    let m = txt.match(/SESSION\s*REMAINING[\s\S]{0,40}?(\d{1,2}):(\d{2})/i);
    const remaining = m ? parseInt(m[1], 10) * 60 + parseInt(m[2], 10) : null;
    m = txt.match(/(\d+)\s*\/\s*(\d+)\s*COINS\s*TODAY/i);
    const daily = m ? { cur: parseInt(m[1], 10), max: parseInt(m[2], 10) } : null;
    // "DAILY RESET IN 09h 03m 55s" (h và m có thể vắng khi gần về 0)
    m = txt.match(/DAILY\s*RESET\s*IN[\s\S]{0,20}?(?:(\d+)\s*h\s*)?(?:(\d+)\s*m\s*)?(\d+)\s*s/i);
    const resetSec = m ? (+(m[1] || 0)) * 3600 + (+(m[2] || 0)) * 60 + (+m[3]) : null;
    return {
      remaining, daily, resetSec,
      nextCoin: num(/NEXT\s*COIN\s*IN[\s\S]{0,20}?(\d+)/i),
      earned: num(/SESSION\s*EARNED[\s\S]{0,20}?(\d+)/i),
    };
  }
  let info = { remaining: null, daily: null, resetSec: null, nextCoin: null, earned: null };

  function trackCoins() {
    const d = parseDaily();
    if (!d) return;
    const last = LS.get('fh_lastDaily', null);
    if (last !== null && d.cur > last) {
      stats.totalCoins += d.cur - last;
      saveStats();
      log(`+${d.cur - last} coin (hôm nay ${d.cur}/${d.max})`);
    }
    LS.set('fh_lastDaily', d.cur);
  }

  function sessionCoins() {
    const m = document.body.innerText.match(/SESSION\s*EARNED[\s\S]{0,20}?(\d+)/i);
    if (m) return parseInt(m[1], 10);
    const d = parseDaily();
    const base = ss.get('fh_daily_base');
    if (!d || base === null) return 0;
    return Math.max(0, d.cur - (+base));
  }

  function markRunning(msg) {
    const d = parseDaily();
    ss.set('fh_phase', 'running');
    ss.set('fh_started_at', now());
    ss.set('fh_seen_pos', '1');
    ss.set('fh_daily_base', d ? d.cur : 0);
    log(msg);
  }

  // ---------- Daily Reset: xóa thống kê khi bộ đếm daily về 0 ----------
  // Nhận biết reset bằng 3 dấu hiệu:
  //  1) Mốc reset (now + "DAILY RESET IN") nhảy tới trước hơn 10 phút  => đồng hồ vừa quay vòng
  //  2) Đã quá mốc reset đã lưu mà trang không còn hiển thị đồng hồ (vd. script tắt lúc reset)
  //  3) Số coin hôm nay (x / max) tụt xuống thấp hơn lần trước
  function doDailyReset(why) {
    Object.assign(stats, ZERO_STATS);
    saveStats();
    LS.set('fh_lastDaily', info.daily ? info.daily.cur : null);
    LS.set('fh_restarts', []);
    LS.set('fh_last_reset', now());
    if (ss.get('fh_phase') === 'running') ss.set('fh_daily_base', 0);
    log(`Daily reset (${why}): đã xóa thống kê ngày`);
    if (limitStopped) {
      limitStopped = false;
      log('Đã hết giới hạn hôm qua, tự tải lại để chạy tiếp');
      setTimeout(() => { ss.set('fh_self', '1'); location.href = '/coins'; }, 3000);
    }
  }

  function checkDailyReset() {
    const t = now();
    const stored = LS.get('fh_reset_at', 0);
    let why = null, target = null;
    if (info.resetSec !== null) {
      target = t + info.resetSec * 1000;
      if (stored && target > stored + CFG.resetJumpMs) why = 'đồng hồ reset đã về 0';
    } else if (stored && t > stored + CFG.resetStaleMs) {
      why = 'đã qua mốc reset';
    }
    if (!why && info.daily) {
      const last = LS.get('fh_lastDaily', null);
      if (last !== null && info.daily.cur < last) why = 'coin hôm nay về 0';
    }
    if (why) doDailyReset(why);
    if (target !== null) { if (!stored || Math.abs(target - stored) > 2500 || why) LS.set('fh_reset_at', target); }
    else if (why) LS.set('fh_reset_at', 0);
    if (info.daily) LS.set('fh_daily', info.daily);
  }

  // ---------- Chống lặp vô tận ----------
  // Ghi nhận mỗi lần bị đưa về /coins bất thường; quá nhiều lần trong thời gian ngắn thì tự dừng.
  function pushRestart(reason) {
    const t = now();
    const hist = LS.get('fh_restarts', []).filter(x => t - x < CFG.loopWindowMs);
    hist.push(t);
    LS.set('fh_restarts', hist);
    if (hist.length >= CFG.loopMax) {
      ui.paused = true; saveUI();
      LS.set('fh_restarts', []);
      status = 'Đã dừng vì lặp';
      log(`Dừng: lặp ${hist.length} lần trong ${Math.round(CFG.loopWindowMs / 60000)} phút (lý do cuối: ${reason}). Đã tạm dừng, đọc log rồi bấm Chạy.`);
      return true;
    }
    return false;
  }

  function restart(reason) {
    if (ss.get('fh_phase') === 'running') {
      const el = now() - (+ss.get('fh_started_at') || now());
      stats.sessions++;
      saveStats();
      log(`Phiên #${stats.sessions} xong: AFK ${fmt(el)}, +${sessionCoins()} coin`);
      LS.set('fh_restarts', []); // phiên chạy thật => reset bộ đếm lặp
    } else if (pushRestart(reason)) {
      return;
    }
    log('Về /coins: ' + reason);
    ss.set('fh_self', '1');
    location.href = '/coins';
  }

  // ---------- Trang /coins ----------
  let coinsAt = 0, coinsDelay = 0;

  function initCoins() {
    // Nếu vào /coins mà từng ở /earn và KHÔNG phải do script => trang tự đá về
    if (ss.get('fh_page_at') && !ss.get('fh_self')) {
      log('Cảnh báo: trang tự đưa về /coins (không phải do script)');
      if (pushRestart('trang tự chuyển')) { clearEarnState(); return false; }
    }
    clearEarnState();
    return true;
  }
  function clearEarnState() {
    ['fh_phase', 'fh_started_at', 'fh_page_at', 'fh_hold_sent_at', 'fh_hold_ms', 'fh_seen_pos', 'fh_daily_base', 'fh_self']
      .forEach(ss.del);
  }

  function handleCoins() {
    const btn = findByText(/^start\s*earning(\s|$)/i);
    if (!btn) { status = 'Chờ nút Start Earning'; return; }
    if (!coinsAt) {
      coinsAt = now(); coinsDelay = rnd(CFG.coinsDelayMin, CFG.coinsDelayMax);
      log(`Thấy Start Earning, chờ ${(coinsDelay / 1000).toFixed(1)}s`);
    }
    if (now() - coinsAt < coinsDelay) { status = 'Chờ ngẫu nhiên trước khi bấm Start'; return; }
    log('Bấm START EARNING');
    status = 'Đang chuyển sang /earn';
    clickable(btn).click();
    coinsAt = 0;
    setTimeout(() => { if (route() === 'coins') location.href = '/earn'; }, 3000);
  }

  // ---------- Trang /earn ----------
  let holding = false, cfOkAt = 0, cfDelay = 0;

  const turnstileDone = () => {
    const inp = document.querySelector('input[name="cf-turnstile-response"], input[name="cf-chl-widget-response"]');
    return !!(inp && inp.value);
  };
  const turnstilePresent = () =>
    !!document.querySelector('.cf-turnstile, input[name="cf-turnstile-response"], iframe[src*="challenges.cloudflare.com"]');

  function fire(el, type, Ctor, pos) {
    const r = el.getBoundingClientRect();
    el.dispatchEvent(new (Ctor || MouseEvent)(type, {
      bubbles: true, cancelable: true, view: window,
      clientX: r.left + r.width * pos.x, clientY: r.top + r.height * pos.y,
      pointerId: 1, pointerType: 'mouse', isPrimary: true, button: 0, buttons: 1,
    }));
  }

  function holdButton(el) {
    if (holding) return;
    holding = true;
    const holdMs = rnd(CFG.holdMinMs, CFG.holdMaxMs);
    const pos = { x: rnd(0.3, 0.7), y: rnd(0.3, 0.7) };
    ss.set('fh_phase', 'hold_sent');
    ss.set('fh_hold_sent_at', now());
    ss.set('fh_hold_ms', Math.round(holdMs));
    log(`Giữ nút HOLD TO START ${(holdMs / 1000).toFixed(1)}s`);
    status = 'Đang giữ nút';
    fire(el, 'pointerdown', PointerEvent, pos);
    setTimeout(() => fire(el, 'mousedown', MouseEvent, pos), rnd(10, 60));
    try { el.dispatchEvent(new TouchEvent('touchstart', { bubbles: true, cancelable: true })); } catch (e) {}
    setTimeout(() => {
      fire(el, 'pointerup', PointerEvent, pos);
      fire(el, 'mouseup', MouseEvent, pos);
      try { el.dispatchEvent(new TouchEvent('touchend', { bubbles: true, cancelable: true })); } catch (e) {}
      holding = false;
    }, holdMs);
  }

  function handleEarn() {
    if (!ss.get('fh_page_at')) ss.set('fh_page_at', now());
    const pageAt = +ss.get('fh_page_at');
    trackCoins();
    if (now() - pageAt < CFG.graceMs) { status = 'Chờ trang load'; return; }

    if (dailyLimitReached()) { status = 'Đã đạt giới hạn hôm nay'; log('Đã đạt giới hạn hôm nay, dừng.'); limitStopped = true; return 'stop'; }

    const phase = ss.get('fh_phase');
    const holdEl = findByText(/hold\s*to\s*start/i);
    const rem = parseRemainingSec();

    if (phase === 'running') {
      status = 'Đang AFK' + (rem !== null ? ` (còn ${Math.floor(rem / 60)}:${String(rem % 60).padStart(2, '0')})` : '');
      if (holdEl) return restart('nút Hold hiện lại => phiên đã kết thúc');
      if (rem !== null && rem > 5) ss.set('fh_seen_pos', '1');
      if (ss.get('fh_seen_pos') && rem !== null && rem <= 3) return restart('hết phiên');
      if (now() - (+ss.get('fh_started_at') || now()) > CFG.sessionMaxMs) return restart('quá thời gian tối đa');
      return;
    }

    if (phase === 'hold_sent') {
      const sentAt = +ss.get('fh_hold_sent_at');
      const holdMs = +ss.get('fh_hold_ms') || CFG.holdMaxMs;
      if (!holdEl && rem !== null && rem > 5) markRunning('Phiên bắt đầu');
      else if (now() - sentAt > holdMs + 5000) { log('Giữ nút chưa có tác dụng, thử lại'); ss.del('fh_phase'); cfOkAt = 0; }
      return;
    }

    if (holdEl) {
      if (!turnstileDone()) {
        status = 'Chờ Cloudflare xác minh';
        if (now() - pageAt > CFG.turnstileWaitMs) return restart('Cloudflare quá lâu');
        return;
      }
      if (!cfOkAt) {
        cfOkAt = now(); cfDelay = rnd(CFG.cfDelayMin, CFG.cfDelayMax);
        log(`Cloudflare OK, chờ ${(cfDelay / 1000).toFixed(1)}s rồi giữ nút`);
      }
      if (now() - cfOkAt < cfDelay) { status = 'Chờ ngẫu nhiên sau Cloudflare'; return; }
      holdButton(clickable(holdEl));
      return;
    }

    if (!turnstilePresent() && rem !== null && rem > 5) { markRunning('Tiếp tục phiên đang chạy'); return; }
    status = 'Chờ giao diện';
    if (now() - pageAt > CFG.turnstileWaitMs) restart('trang không phản hồi');
  }

  // ---------- Giao diện (Shadow DOM) ----------
  const ICON = {
    bolt: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 4 14h7l-1 8 9-12h-7l1-8z"/></svg>',
    play: '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M8 5.5v13a1 1 0 0 0 1.5.86l10.5-6.5a1 1 0 0 0 0-1.72L9.5 4.64A1 1 0 0 0 8 5.5z"/></svg>',
    pause: '<svg viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="5" width="4" height="14" rx="1.2"/><rect x="14" y="5" width="4" height="14" rx="1.2"/></svg>',
    close: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M6 6l12 12M18 6 6 18"/></svg>',
    clock: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>',
    timer: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 2h4M12 14l3-3"/><circle cx="12" cy="14" r="8"/></svg>',
    layers: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m12 3 9 5-9 5-9-5 9-5z"/><path d="m3 13 9 5 9-5"/></svg>',
    monitor: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="12" rx="2"/><path d="M8 20h8M12 16v4"/></svg>',
    coin: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M14.5 9.2c-.5-.8-1.4-1.2-2.5-1.2-1.4 0-2.5.8-2.5 2s1 1.7 2.5 2 2.5.8 2.5 2-1.1 2-2.5 2c-1.1 0-2-.4-2.5-1.2M12 6.5V8m0 8v1.5"/></svg>',
    refresh: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12a9 9 0 1 1-3-6.7L21 8"/><path d="M21 3v5h-5"/></svg>',
    list: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M8 6h12M8 12h12M8 18h12M4 6h.01M4 12h.01M4 18h.01"/></svg>',
    grip: '<svg viewBox="0 0 24 24" fill="currentColor"><circle cx="9" cy="6" r="1.4"/><circle cx="15" cy="6" r="1.4"/><circle cx="9" cy="12" r="1.4"/><circle cx="15" cy="12" r="1.4"/><circle cx="9" cy="18" r="1.4"/><circle cx="15" cy="18" r="1.4"/></svg>',
  };

  function buildUI() {
    const host = document.createElement('div');
    host.id = 'fh-host';
    host.style.cssText = 'all:initial;';
    document.body.appendChild(host);
    const root = host.attachShadow({ mode: 'open' });

    root.innerHTML = `
      <style>
        :host { all: initial; }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        svg { width: 100%; height: 100%; display: block; pointer-events: none; }
        i { font-style: normal; }

        /* Reset nút: tránh bị CSS mặc định / CSS của trang làm lệch */
        button {
          -webkit-appearance: none; appearance: none; border: 0; background: none; outline: none;
          font-family: inherit; font-size: inherit; font-weight: inherit; line-height: 1; color: inherit;
          cursor: pointer; display: inline-flex; align-items: center; justify-content: center;
          -webkit-tap-highlight-color: transparent;
        }
        button:focus-visible, #fh-toggle:focus-visible { outline: 2px solid var(--tone, #60a5fa); outline-offset: 2px; }

        #fh-pos {
          position: fixed; left: 0; top: 0; width: 336px; z-index: 2147483647;
          will-change: transform; pointer-events: none;
          font: 13px/1.45 Inter, "SF Pro Text", "Segoe UI", Roboto, system-ui, sans-serif;
          color: #e8eaf2; -webkit-font-smoothing: antialiased;
        }
        #fh-panel {
          --tone: #60a5fa; --tone-soft: rgba(96,165,250,.14); --tone-line: rgba(96,165,250,.3);
          position: relative; pointer-events: auto; overflow: hidden;
          border-radius: 18px; user-select: none;
          background:
            radial-gradient(120% 80% at 0% 0%, rgba(99,102,241,.22), transparent 55%),
            radial-gradient(100% 70% at 100% 100%, rgba(34,211,238,.14), transparent 55%),
            rgba(14,16,28,.88);
          -webkit-backdrop-filter: blur(22px) saturate(170%); backdrop-filter: blur(22px) saturate(170%);
          border: 1px solid rgba(255,255,255,.09);
          box-shadow: 0 24px 60px -12px rgba(0,0,0,.65), 0 0 0 1px rgba(0,0,0,.4), inset 0 1px 0 rgba(255,255,255,.07);
          transform-origin: 0% 100%;
          transition: opacity .28s cubic-bezier(.2,.8,.2,1), transform .34s cubic-bezier(.2,.9,.25,1.1), visibility 0s linear 0s;
        }
        #fh-panel.off { opacity: 0; transform: scale(.92) translateY(14px); visibility: hidden; pointer-events: none;
          transition: opacity .2s ease, transform .24s ease, visibility 0s linear .24s; }
        #fh-panel[data-tone="ok"]   { --tone: #34d399; --tone-soft: rgba(52,211,153,.14);  --tone-line: rgba(52,211,153,.3); }
        #fh-panel[data-tone="warn"] { --tone: #fbbf24; --tone-soft: rgba(251,191,36,.14);  --tone-line: rgba(251,191,36,.3); }
        #fh-panel[data-tone="err"]  { --tone: #f87171; --tone-soft: rgba(248,113,113,.15); --tone-line: rgba(248,113,113,.32); }
        #fh-panel[data-tone="acc"]  { --tone: #a78bfa; --tone-soft: rgba(167,139,250,.15); --tone-line: rgba(167,139,250,.32); }

        /* Header */
        #fh-head { display: flex; align-items: center; gap: 10px; padding: 12px 12px 10px 14px; cursor: grab; touch-action: none; }
        #fh-head.drag { cursor: grabbing; }
        .logo { width: 32px; height: 32px; border-radius: 10px; padding: 7px; color: #fff; flex: none;
          background: linear-gradient(135deg, #6366f1, #22d3ee); box-shadow: 0 6px 16px -4px rgba(99,102,241,.7); }
        .ttl { flex: 1; min-width: 0; }
        .ttl b { display: block; font-size: 13.5px; font-weight: 650; letter-spacing: .1px; }
        .ttl span { display: block; font-size: 11px; color: #8a90a8; }
        .grip { width: 14px; height: 14px; color: #5a6078; flex: none; }
        .ibtn { width: 28px; height: 28px; min-width: 28px; border-radius: 9px; padding: 7px; flex: none;
          background: rgba(255,255,255,.06); color: #aab0c6; transition: background .18s, color .18s, transform .18s; }
        .ibtn:hover { background: rgba(255,255,255,.14); color: #fff; }
        .ibtn:active { transform: scale(.9); }

        /* Body */
        #fh-body { padding: 2px 14px 14px; display: grid; gap: 10px; }
        .card { border-radius: 14px; background: rgba(255,255,255,.04); border: 1px solid rgba(255,255,255,.06); }

        /* Status */
        #fh-stat { display: flex; align-items: center; gap: 10px; padding: 9px 9px 9px 12px; background: var(--tone-soft);
          border-color: var(--tone-line); transition: background .4s, border-color .4s; }
        .dot { position: relative; width: 10px; height: 10px; border-radius: 50%; background: var(--tone); flex: none; transition: background .4s; }
        .dot::after { content: ""; position: absolute; inset: 0; border-radius: 50%; background: var(--tone);
          animation: ping 1.8s cubic-bezier(0,0,.2,1) infinite; }
        #fh-panel[data-tone="warn"] .dot::after, #fh-panel[data-tone="err"] .dot::after { animation: none; opacity: 0; }
        @keyframes ping { 0% { transform: scale(1); opacity: .65; } 80%, 100% { transform: scale(3); opacity: 0; } }
        #fh-status { flex: 1; min-width: 0; font-weight: 600; color: var(--tone); white-space: nowrap; overflow: hidden;
          text-overflow: ellipsis; transition: color .4s; }
        #fh-pause { gap: 6px; height: 30px; min-width: 74px; padding: 0 12px 0 10px; border-radius: 9px;
          font-size: 12px; font-weight: 650; letter-spacing: .2px; color: #0b1020; background: var(--tone); flex: none;
          transition: transform .18s, filter .18s, background .4s; }
        #fh-pause:hover { filter: brightness(1.12); }
        #fh-pause:active { transform: scale(.95); }
        #fh-pause i { width: 12px; height: 12px; display: block; flex: none; }
        #fh-pause span { display: block; white-space: nowrap; }

        /* Session */
        #fh-sess-card { padding: 12px 14px 13px; }
        .row { display: flex; align-items: flex-end; justify-content: space-between; gap: 10px; }
        .lbl { font-size: 10.5px; letter-spacing: .09em; text-transform: uppercase; color: #7d839b; font-weight: 600; }
        .big { font: 600 26px/1.1 ui-monospace, "SF Mono", Consolas, monospace; font-variant-numeric: tabular-nums; letter-spacing: -.5px; margin-top: 3px; }
        .big.idle { color: #5d6379; }
        .chip { display: inline-flex; align-items: center; gap: 5px; padding: 4px 10px 4px 7px; border-radius: 999px; font-weight: 650;
          font-size: 12px; color: #34d399; background: rgba(52,211,153,.12); font-variant-numeric: tabular-nums; flex: none; }
        .chip i { width: 13px; height: 13px; display: block; }
        .bar { margin-top: 11px; height: 6px; border-radius: 999px; background: rgba(255,255,255,.07); overflow: hidden; }
        .bar > div { height: 100%; width: 0%; border-radius: inherit; position: relative; overflow: hidden;
          background: linear-gradient(90deg, #6366f1, #22d3ee); transition: width .9s cubic-bezier(.3,.7,.2,1); }
        .bar > div::after { content: ""; position: absolute; inset: 0; transform: translateX(-100%);
          background: linear-gradient(90deg, transparent, rgba(255,255,255,.45), transparent); animation: shine 2.2s ease-in-out infinite; }
        .bar.idle > div::after { animation: none; opacity: 0; }
        .bar.daily > div { background: linear-gradient(90deg, #10b981, #34d399); }
        .bar.daily > div::after { animation: none; opacity: 0; }
        .bar.daily.hot > div { background: linear-gradient(90deg, #f59e0b, #f87171); }
        @keyframes shine { to { transform: translateX(100%); } }

        /* Tiles */
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
        .tile { padding: 10px 11px; display: flex; gap: 9px; align-items: center; min-width: 0; transition: background .2s, transform .2s; }
        .tile:hover { background: rgba(255,255,255,.07); transform: translateY(-1px); }
        .tile .ic { width: 28px; height: 28px; padding: 6px; border-radius: 9px; flex: none; color: var(--c);
          background: rgba(255,255,255,.06); background: color-mix(in srgb, var(--c) 16%, transparent); }
        .tile .tx { min-width: 0; }
        .tile .v { font: 650 15px/1.15 ui-monospace, "SF Mono", Consolas, monospace; font-variant-numeric: tabular-nums; white-space: nowrap; }
        .tile .k { font-size: 10.5px; color: #7d839b; margin-top: 1px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

        /* Daily */
        #fh-daily { padding: 12px 14px 12px; }
        #fh-daily .top { display: flex; align-items: baseline; justify-content: space-between; gap: 8px; }
        #fh-daily .val { font: 650 14px/1.2 ui-monospace, "SF Mono", Consolas, monospace; font-variant-numeric: tabular-nums; }
        #fh-daily .val em { font-style: normal; color: #7d839b; font-weight: 500; font-size: 11px; margin-left: 6px; }
        #fh-daily .bot { margin-top: 10px; display: flex; align-items: center; justify-content: space-between; gap: 8px; }
        #fh-daily .rs { display: flex; align-items: center; gap: 6px; color: #7d839b; font-size: 11px; }
        #fh-daily .rs i { width: 13px; height: 13px; display: block; color: #a78bfa; flex: none; }
        #fh-reset { font: 650 13px/1.2 ui-monospace, "SF Mono", Consolas, monospace; font-variant-numeric: tabular-nums; color: #e8eaf2; }
        #fh-daily .note { margin-top: 7px; font-size: 10.5px; color: #596078; }

        /* Log */
        #fh-logcard { padding: 8px 4px 6px 12px; }
        .lh { display: flex; align-items: center; gap: 6px; padding-right: 8px; margin-bottom: 4px; }
        .lh i { width: 12px; height: 12px; color: #7d839b; display: block; }
        #fh-log { max-height: 118px; overflow-y: auto; padding-right: 6px; user-select: text;
          font: 11px/1.5 ui-monospace, "SF Mono", Consolas, monospace; scroll-behavior: smooth;
          -webkit-mask-image: linear-gradient(to bottom, transparent 0, #000 12px); mask-image: linear-gradient(to bottom, transparent 0, #000 12px); }
        #fh-log::-webkit-scrollbar { width: 5px; }
        #fh-log::-webkit-scrollbar-thumb { background: rgba(255,255,255,.14); border-radius: 9px; }
        .ln { display: flex; gap: 8px; padding: 1px 0; color: #98a0b8; }
        .ln time { color: #596078; flex: none; }
        .ln span { word-break: break-word; }
        .ln.ok span { color: #34d399; }
        .ln.warn span { color: #fbbf24; }
        .ln.err span { color: #f87171; }
        .ln.rst span { color: #a78bfa; }
        .ln.new { animation: lin .35s ease-out; }
        @keyframes lin { from { opacity: 0; transform: translateY(5px); } to { opacity: 1; transform: none; } }
        .empty { color: #596078; padding: 4px 0; }

        .foot { text-align: center; font-size: 10.5px; color: #596078; }
        kbd { font: 600 10px ui-monospace, Consolas, monospace; padding: 1px 5px; border-radius: 5px; background: rgba(255,255,255,.08); color: #98a0b8; }

        /* Nút nổi */
        #fh-toggle { position: fixed; left: 18px; bottom: 18px; width: 46px; height: 46px; border-radius: 15px; padding: 12px; z-index: 2147483647;
          display: flex; align-items: center; justify-content: center; cursor: pointer; color: #fff; user-select: none;
          border: 1px solid rgba(255,255,255,.14);
          background: linear-gradient(135deg, #6366f1, #22d3ee);
          box-shadow: 0 10px 26px -6px rgba(99,102,241,.75), inset 0 1px 0 rgba(255,255,255,.3);
          transition: transform .25s cubic-bezier(.2,.9,.25,1.2), box-shadow .25s; }
        #fh-toggle:hover { transform: translateY(-2px) scale(1.06); }
        #fh-toggle:active { transform: scale(.93); }
        #fh-toggle .st { position: absolute; right: -3px; top: -3px; width: 13px; height: 13px; border-radius: 50%;
          background: var(--tone, #60a5fa); border: 2px solid #0e101c; transition: background .4s; }

        @media (prefers-reduced-motion: reduce) { * { animation: none !important; transition-duration: .01s !important; } }
      </style>

      <div id="fh-pos">
        <div id="fh-panel" data-tone="info">
          <div id="fh-head">
            <div class="logo">${ICON.bolt}</div>
            <div class="ttl"><b>FreezeHost AFK</b><span>Tự động kiếm coin</span></div>
            <div class="grip">${ICON.grip}</div>
            <button class="ibtn" id="fh-hide" type="button" title="Ẩn (Alt+Z)" aria-label="Ẩn bảng">${ICON.close}</button>
          </div>
          <div id="fh-body">
            <div class="card" id="fh-stat">
              <span class="dot"></span>
              <span id="fh-status"></span>
              <button id="fh-pause" type="button"><i></i><span></span></button>
            </div>

            <div class="card" id="fh-sess-card">
              <div class="row">
                <div>
                  <div class="lbl">Phiên hiện tại</div>
                  <div class="big idle" id="fh-cur">--:--:--</div>
                </div>
                <div class="chip" title="Session earned"><i>${ICON.coin}</i><span id="fh-scoin">0</span></div>
              </div>
              <div class="bar idle" id="fh-bar"><div></div></div>
            </div>

            <div class="grid">
              <div class="card tile" style="--c:#60a5fa"><div class="ic">${ICON.timer}</div><div class="tx"><div class="v" id="fh-next">--</div><div class="k">Coin kế tiếp sau</div></div></div>
              <div class="card tile" style="--c:#fb923c"><div class="ic">${ICON.clock}</div><div class="tx"><div class="v" id="fh-rem">--:--</div><div class="k">Phiên còn lại</div></div></div>
            </div>

            <div class="card" id="fh-daily">
              <div class="top">
                <span class="lbl">Giới hạn hôm nay</span>
                <span class="val"><span id="fh-dcur">--</span><span id="fh-dmax" style="color:#7d839b"></span><em id="fh-dpct"></em></span>
              </div>
              <div class="bar daily" id="fh-dbar"><div></div></div>
              <div class="bot">
                <span class="rs"><i>${ICON.refresh}</i>Daily reset sau</span>
                <span id="fh-reset">--</span>
              </div>
              <div class="note">Thống kê bên dưới tự xóa khi đồng hồ này về 0</div>
            </div>

            <div class="grid">
              <div class="card tile" style="--c:#60a5fa"><div class="ic">${ICON.clock}</div><div class="tx"><div class="v" id="fh-afk">0:00:00</div><div class="k">AFK hôm nay</div></div></div>
              <div class="card tile" style="--c:#a78bfa"><div class="ic">${ICON.layers}</div><div class="tx"><div class="v" id="fh-sess">0</div><div class="k">Phiên hoàn tất</div></div></div>
              <div class="card tile" style="--c:#f472b6"><div class="ic">${ICON.monitor}</div><div class="tx"><div class="v" id="fh-ads">0</div><div class="k">Quảng cáo</div></div></div>
              <div class="card tile" style="--c:#34d399"><div class="ic">${ICON.coin}</div><div class="tx"><div class="v" id="fh-total">0</div><div class="k">Coin hôm nay</div></div></div>
            </div>

            <div class="card" id="fh-logcard">
              <div class="lh"><i>${ICON.list}</i><span class="lbl">Nhật ký</span></div>
              <div id="fh-log"></div>
            </div>

            <div class="foot"><kbd>Alt</kbd> + <kbd>Z</kbd> ẩn / hiện</div>
          </div>
        </div>
      </div>
      <button id="fh-toggle" type="button" title="Mở bảng (Alt+Z)" aria-label="Mở bảng">${ICON.bolt}<span class="st"></span></button>`;

    const $ = id => root.querySelector(id);
    const pos = $('#fh-pos');
    const panel = $('#fh-panel');
    const toggle = $('#fh-toggle');
    const pauseBtn = $('#fh-pause');
    const pauseIcon = pauseBtn.querySelector('i');
    const pauseTxt = pauseBtn.querySelector('span');
    const head = $('#fh-head');

    const clampPos = () => {
      const w = pos.offsetWidth || 336, h = panel.offsetHeight || 200;
      ui.x = Math.min(Math.max(8, ui.x), Math.max(8, innerWidth - w - 8));
      ui.y = Math.min(Math.max(8, ui.y), Math.max(8, innerHeight - Math.min(h, innerHeight - 16) - 8));
    };
    const place = () => { pos.style.transform = `translate3d(${Math.round(ui.x)}px, ${Math.round(ui.y)}px, 0)`; };
    clampPos(); place();
    addEventListener('resize', () => { clampPos(); place(); });

    const setVisible = v => {
      ui.visible = v;
      panel.classList.toggle('off', !v);
      saveUI();
    };
    panel.classList.toggle('off', !ui.visible);
    toggle.onclick = () => setVisible(!ui.visible);
    $('#fh-hide').onclick = () => setVisible(false);
    document.addEventListener('keydown', e => {
      if (e.altKey && e.code === 'KeyZ') { e.preventDefault(); setVisible(!ui.visible); }
    });

    pauseBtn.onclick = () => {
      ui.paused = !ui.paused; saveUI();
      if (!ui.paused) LS.set('fh_restarts', []);
      log(ui.paused ? 'Tạm dừng tự động' : 'Tiếp tục tự động');
    };

    // Kéo thả (transform, mượt, không gây reflow)
    let drag = null;
    head.addEventListener('pointerdown', e => {
      if (e.target.closest('button')) return;
      drag = { dx: e.clientX - ui.x, dy: e.clientY - ui.y };
      head.classList.add('drag');
      head.setPointerCapture(e.pointerId);
    });
    head.addEventListener('pointermove', e => {
      if (!drag) return;
      ui.x = e.clientX - drag.dx;
      ui.y = e.clientY - drag.dy;
      clampPos(); place();
    });
    const endDrag = () => { if (drag) { drag = null; head.classList.remove('drag'); saveUI(); } };
    head.addEventListener('pointerup', endDrag);
    head.addEventListener('pointercancel', endDrag);

    // Số đếm chạy mượt
    const tween = (el, to) => {
      const from = el._v === undefined ? to : el._v;
      if (from === to) { el.textContent = to; el._v = to; return; }
      el._v = to;
      const t0 = performance.now(), dur = 450;
      cancelAnimationFrame(el._raf);
      const step = t => {
        const p = Math.min(1, (t - t0) / dur), e = 1 - Math.pow(1 - p, 3);
        el.textContent = Math.round(from + (to - from) * e);
        if (p < 1) el._raf = requestAnimationFrame(step);
      };
      el._raf = requestAnimationFrame(step);
    };
    const setText = (el, v) => { if (el._t !== v) { el._t = v; el.textContent = v; } };

    const toneOf = () => {
      if (ui.paused) return status === 'Đã dừng vì lặp' ? 'err' : 'warn';
      if (status.startsWith('Đang AFK')) return 'ok';
      if (status.startsWith('Đã đạt giới hạn')) return 'warn';
      if (status === 'Đang giữ nút' || status.startsWith('Đang chuyển')) return 'acc';
      return 'info';
    };
    const lineClass = m => {
      if (/^Daily reset/.test(m)) return 'rst';
      if (/^(Dừng|Cảnh báo)/.test(m)) return /^Dừng/.test(m) ? 'err' : 'warn';
      if (/^\+\d+ coin|^Phiên #|^Phiên bắt đầu|Cloudflare OK/.test(m)) return 'ok';
      return '';
    };

    let shownVer = -1, lastLogCount = logs.length;
    return function render() {
      const running = ss.get('fh_phase') === 'running';
      const tone = toneOf();
      panel.dataset.tone = tone;
      toggle.style.setProperty('--tone', getComputedStyle(panel).getPropertyValue('--tone').trim() || '#60a5fa');

      if (pauseBtn._p !== ui.paused) {
        pauseBtn._p = ui.paused;
        pauseIcon.innerHTML = ui.paused ? ICON.play : ICON.pause;
        pauseTxt.textContent = ui.paused ? 'Chạy' : 'Dừng';
      }
      setText($('#fh-status'), ui.paused && status !== 'Đã dừng vì lặp' ? 'Tạm dừng' : status);

      // Phiên hiện tại
      const el = running ? now() - (+ss.get('fh_started_at') || now()) : 0;
      const cur = $('#fh-cur');
      setText(cur, running ? fmt(el) : '--:--:--');
      cur.classList.toggle('idle', !running);
      const bar = $('#fh-bar');
      bar.classList.toggle('idle', !running || ui.paused);
      let pct = 0;
      if (running) {
        const total = el + (info.remaining !== null ? info.remaining * 1000 : Math.max(0, CFG.sessionMaxMs - el));
        pct = total > 0 ? Math.min(100, (el / total) * 100) : 0;
      }
      bar.firstElementChild.style.width = pct.toFixed(2) + '%';
      tween($('#fh-scoin'), running ? (info.earned !== null ? info.earned : sessionCoins()) : 0);

      // Thông số trên trang
      setText($('#fh-next'), info.nextCoin !== null ? info.nextCoin + 's' : '--');
      setText($('#fh-rem'), info.remaining !== null
        ? `${String(Math.floor(info.remaining / 60)).padStart(2, '0')}:${String(info.remaining % 60).padStart(2, '0')}` : '--:--');

      // Daily
      const dd = info.daily || LS.get('fh_daily', null);
      if (dd) {
        const p = dd.max > 0 ? (dd.cur / dd.max) * 100 : 0;
        setText($('#fh-dcur'), String(dd.cur));
        setText($('#fh-dmax'), ' / ' + dd.max);
        setText($('#fh-dpct'), `(${p < 10 ? p.toFixed(1).replace(/\.0$/, '') : Math.round(p)}%)`);
        const db = $('#fh-dbar');
        db.firstElementChild.style.width = Math.min(100, p).toFixed(2) + '%';
        db.classList.toggle('hot', p >= 85);
      } else {
        setText($('#fh-dcur'), '--'); setText($('#fh-dmax'), ''); setText($('#fh-dpct'), '');
      }
      const ra = LS.get('fh_reset_at', 0);
      setText($('#fh-reset'), ra ? fmtHMS(ra - now()) : '--');

      // Thống kê (reset theo ngày)
      setText($('#fh-afk'), fmt(stats.totalAfkMs));
      tween($('#fh-sess'), stats.sessions);
      tween($('#fh-ads'), stats.ads);
      tween($('#fh-total'), stats.totalCoins);

      if (shownVer !== logVer) {
        shownVer = logVer;
        const box = $('#fh-log');
        const list = logs.slice(-30);
        const fresh = logs.length !== lastLogCount;
        lastLogCount = logs.length;
        box.innerHTML = list.length
          ? list.map((l, i) => {
              const t = l.slice(0, 8), m = l.slice(9).replace(/&/g, '&amp;').replace(/</g, '&lt;');
              const cls = lineClass(l.slice(9));
              return `<div class="ln ${cls}${fresh && i === list.length - 1 ? ' new' : ''}"><time>${t}</time><span>${m}</span></div>`;
            }).join('')
          : '<div class="empty">Chưa có hoạt động</div>';
        box.scrollTop = box.scrollHeight;
      }
    };
  }

  // ---------- Khởi động ----------
  const render = buildUI();
  log('Script v4.1 chạy trên ' + location.pathname);
  try {
    const lc = JSON.parse(ss.get('fh_last_click') || 'null');
    if (lc && now() - lc.at < 4000) log(`Cảnh báo: vừa bấm "${lc.t}" trước khi đổi trang, có thể là nút gây chuyển trang`);
  } catch (e) {}

  adLoop();

  let lastTick = now();
  setInterval(() => {                       // đọc trang + Daily Reset + UI + cộng dồn thời gian AFK mỗi giây
    const t = now(), dt = Math.min(t - lastTick, 5000);
    lastTick = t;
    try { info = readPage(); checkDailyReset(); } catch (e) {}
    if (!ui.paused && route() === 'earn' && ss.get('fh_phase') === 'running') {
      stats.totalAfkMs += dt;
      saveStats();
    }
    render();
  }, 1000);

  let lastRoute = null, coinsReady = false;
  const loop = setInterval(() => {          // logic chính
    if (ui.paused) return;
    const r = route();
    if (r !== lastRoute) {                  // xử lý cả trường hợp web đổi trang không reload (SPA)
      lastRoute = r;
      coinsAt = 0; cfOkAt = 0;
      coinsReady = (r === 'coins') ? initCoins() : false;
    }
    try { info = readPage(); checkDailyReset(); } catch (e) {}  // luôn kiểm tra reset trước khi đếm coin
    closePopups();
    if (r === 'coins') { if (coinsReady) handleCoins(); }
    else if (r === 'earn') { if (handleEarn() === 'stop') clearInterval(loop); }
    else status = 'Không phải trang /coins hay /earn';
  }, CFG.tick);
})();
