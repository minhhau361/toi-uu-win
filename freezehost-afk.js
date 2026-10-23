// ==UserScript==
// @name         FreezeHost Auto AFK + Ads + Panel
// @namespace    http://tampermonkey.net/
// @version      3.1
// @description  Auto Start Earning, giữ Hold to Start, xem quảng cáo thưởng, popup thống kê kéo thả (Alt+Z), delay ngẫu nhiên, chống lặp vô tận. Chỉ chạy ở chế độ desktop.
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

  const stats = Object.assign({ totalCoins: 0, totalAfkMs: 0, sessions: 0, ads: 0 }, LS.get('fh_stats', {}));
  const ui = Object.assign({ x: 20, y: 80, visible: true, paused: false }, LS.get('fh_ui', {}));
  let logs = LS.get('fh_log', []);
  let logVer = 0;
  let status = 'Khởi động...';

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
      log(`⛔ Lặp ${hist.length} lần trong ${Math.round(CFG.loopWindowMs / 60000)} phút (lý do cuối: ${reason}). Đã tạm dừng, đọc log rồi bấm ▶ Chạy.`);
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
      log('⚠ Trang tự đưa về /coins (không phải do script)');
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

    if (dailyLimitReached()) { status = 'Đã đạt giới hạn hôm nay'; log('Đã đạt giới hạn hôm nay, dừng.'); return 'stop'; }

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

  // ---------- Popup (Shadow DOM) ----------
  function buildUI() {
    const host = document.createElement('div');
    host.id = 'fh-host';
    host.style.cssText = 'all:initial;';
    document.body.appendChild(host);
    const root = host.attachShadow({ mode: 'open' });

    root.innerHTML = `
      <style>
        * { box-sizing: border-box; }
        #fh-panel { position: fixed; width: 310px; z-index: 2147483647; background: rgba(15,18,30,.96); color: #e5e7eb;
          font: 12px/1.5 Consolas, monospace; border: 1px solid #2563eb; border-radius: 10px;
          box-shadow: 0 6px 24px rgba(0,0,0,.5); user-select: none; }
        #fh-head { cursor: move; padding: 8px 10px; background: #1d4ed8; border-radius: 9px 9px 0 0;
          display: flex; align-items: center; justify-content: space-between; touch-action: none; }
        button { cursor: pointer; padding: 1px 6px; font: inherit; }
        #fh-body { padding: 8px 10px; }
        #fh-log { margin-top: 6px; max-height: 150px; overflow: auto; border-top: 1px solid #334155; padding-top: 4px;
          color: #94a3b8; font-size: 11px; user-select: text; }
        #fh-toggle { position: fixed; left: 16px; bottom: 16px; width: 38px; height: 38px; border-radius: 50%;
          background: #1d4ed8; color: #fff; font: bold 12px sans-serif; display: flex; align-items: center;
          justify-content: center; cursor: pointer; z-index: 2147483647; box-shadow: 0 2px 10px rgba(0,0,0,.5); user-select: none; }
        b { font-weight: bold; }
      </style>
      <div id="fh-panel">
        <div id="fh-head">
          <b>FreezeHost AFK</b>
          <span><button id="fh-pause" style="margin-right:6px"></button><button id="fh-hide">×</button></span>
        </div>
        <div id="fh-body">
          <div>Trạng thái: <b id="fh-status" style="color:#facc15"></b></div>
          <div>Phiên hiện tại: <b id="fh-cur"></b></div>
          <div>Coin phiên này: <b id="fh-scoin" style="color:#4ade80"></b></div>
          <div>Tổng thời gian AFK: <b id="fh-afk"></b></div>
          <div>Số phiên hoàn tất: <b id="fh-sess"></b> | Quảng cáo: <b id="fh-ads"></b></div>
          <div>Tổng coin đã kiếm: <b id="fh-total" style="color:#4ade80"></b></div>
          <div id="fh-log"></div>
          <div style="margin-top:4px;color:#64748b;font-size:10px;">Alt+Z: ẩn/hiện</div>
        </div>
      </div>
      <div id="fh-toggle">FH</div>`;

    const $ = id => root.querySelector(id);
    const panel = $('#fh-panel');
    panel.style.left = ui.x + 'px';
    panel.style.top = ui.y + 'px';

    const setVisible = v => { ui.visible = v; panel.style.display = v ? 'block' : 'none'; saveUI(); };
    panel.style.display = ui.visible ? 'block' : 'none';
    $('#fh-toggle').onclick = () => setVisible(!ui.visible);
    $('#fh-hide').onclick = () => setVisible(false);
    document.addEventListener('keydown', e => {
      if (e.altKey && e.code === 'KeyZ') { e.preventDefault(); setVisible(!ui.visible); }
    });

    const pauseBtn = $('#fh-pause');
    pauseBtn.onclick = () => {
      ui.paused = !ui.paused; saveUI();
      if (!ui.paused) LS.set('fh_restarts', []);
      log(ui.paused ? 'Tạm dừng tự động' : 'Tiếp tục tự động');
    };

    // Kéo thả
    const head = $('#fh-head');
    let drag = null;
    head.addEventListener('pointerdown', e => {
      if (e.target.tagName === 'BUTTON') return;
      drag = { dx: e.clientX - panel.offsetLeft, dy: e.clientY - panel.offsetTop };
      head.setPointerCapture(e.pointerId);
    });
    head.addEventListener('pointermove', e => {
      if (!drag) return;
      ui.x = Math.min(Math.max(0, e.clientX - drag.dx), innerWidth - 60);
      ui.y = Math.min(Math.max(0, e.clientY - drag.dy), innerHeight - 40);
      panel.style.left = ui.x + 'px';
      panel.style.top = ui.y + 'px';
    });
    head.addEventListener('pointerup', () => { if (drag) { drag = null; saveUI(); } });

    let shownVer = -1;
    return function render() {
      const running = ss.get('fh_phase') === 'running';
      pauseBtn.textContent = ui.paused ? '▶ Chạy' : '⏸ Dừng';
      $('#fh-status').textContent = ui.paused && status !== 'Đã dừng vì lặp' ? 'Tạm dừng' : status;
      $('#fh-cur').textContent = running ? fmt(now() - (+ss.get('fh_started_at') || now())) : '--';
      $('#fh-scoin').textContent = running ? sessionCoins() : 0;
      $('#fh-afk').textContent = fmt(stats.totalAfkMs);
      $('#fh-sess').textContent = stats.sessions;
      $('#fh-ads').textContent = stats.ads;
      $('#fh-total').textContent = stats.totalCoins;
      if (shownVer !== logVer) {
        shownVer = logVer;
        const box = $('#fh-log');
        box.innerHTML = logs.slice(-30).map(l => `<div>${l.replace(/&/g, '&amp;').replace(/</g, '&lt;')}</div>`).join('');
        box.scrollTop = box.scrollHeight;
      }
    };
  }

  // ---------- Khởi động ----------
  const render = buildUI();
  log('Script v3.1 chạy trên ' + location.pathname);
  try {
    const lc = JSON.parse(ss.get('fh_last_click') || 'null');
    if (lc && now() - lc.at < 4000) log(`⚠ Vừa bấm "${lc.t}" trước khi đổi trang, có thể là nút gây chuyển trang`);
  } catch (e) {}

  adLoop();

  let lastTick = now();
  setInterval(() => {                       // UI + cộng dồn thời gian AFK mỗi giây
    const t = now(), dt = Math.min(t - lastTick, 5000);
    lastTick = t;
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
    closePopups();
    if (r === 'coins') { if (coinsReady) handleCoins(); }
    else if (r === 'earn') { if (handleEarn() === 'stop') clearInterval(loop); }
    else status = 'Không phải trang /coins hay /earn';
  }, CFG.tick);
})();