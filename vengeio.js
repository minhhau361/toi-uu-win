// ==UserScript==
// @name         PlayCanvas Aimbot Hack
// @namespace    http://tampermonkey.net
// @version      1.3
// @description  Tự động đổi hướng đạn sang người chơi gần nhất (Aimbot) - Giao diện thông báo mượt mà
// @author       You
// @match        https://*.venge.io/*
// @match        https://*://*
// @grant        none
// @run-at       document-end
// ==/UserScript==

(function() {
    'use strict';

    // Biến quản lý trạng thái Bật/Tắt Aimbot (Mặc định là BẬT khi vào game)
    let isAimbotEnabled = true;

    // Tiêm CSS hiệu ứng thông báo mượt mà vào trang web
    const styleElem = document.createElement('style');
    styleElem.innerHTML = `
        #aimbot-notify {
            position: fixed;
            top: 25px;
            right: 25px;
            padding: 14px 24px;
            border-radius: 12px;
            color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 15px;
            font-weight: 700;
            z-index: 99999;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            opacity: 0;
            transform: translateY(-20px) scale(0.9);
            pointer-events: none;
        }
        #aimbot-notify.show {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
        #aimbot-notify.success {
            background: rgba(46, 204, 113, 0.15);
            border: 1px solid rgba(46, 204, 113, 0.5);
            box-shadow: 0 0 20px rgba(46, 204, 113, 0.25), 0 10px 30px rgba(0,0,0,0.4);
        }
        #aimbot-notify.error {
            background: rgba(231, 76, 60, 0.15);
            border: 1px solid rgba(231, 76, 60, 0.5);
            box-shadow: 0 0 20px rgba(231, 76, 60, 0.25), 0 10px 30px rgba(0,0,0,0.4);
        }
    `;
    document.head.appendChild(styleElem);

    let hideTimeout = null;

    // Hàm tạo và hiển thị thông báo với hiệu ứng cực mượt
    function showNotification(message, isSuccess) {
        let notifyDiv = document.getElementById('aimbot-notify');
        if (!notifyDiv) {
            notifyDiv = document.createElement('div');
            notifyDiv.id = 'aimbot-notify';
            document.body.appendChild(notifyDiv);
        }

        // Xóa timeout cũ nếu người dùng bấm liên tục
        if (hideTimeout) clearTimeout(hideTimeout);

        // Reset class để kích hoạt lại animation transition
        notifyDiv.className = '';
        notifyDiv.innerText = message;

        // Ép trình duyệt render lại trước khi add class hiển thị
        void notifyDiv.offsetWidth;
        notifyDiv.classList.add('show', isSuccess ? 'success' : 'error');

        // Tự động ẩn thông báo sau 2 giây với hiệu ứng mượt
        hideTimeout = setTimeout(() => {
            notifyDiv.classList.remove('show');
        }, 2000);
    }

    // Lắng nghe sự kiện nhấn phím Z
    window.addEventListener('keydown', function(event) {
        // Kiểm tra nếu người chơi đang gõ chữ trong ô chat thì bỏ qua không kích hoạt phím tắt
        if (document.activeElement.tagName === 'INPUT' || document.activeElement.tagName === 'TEXTAREA') {
            return;
        }

        if (event.key.toLowerCase() === 'z') {
            isAimbotEnabled = !isAimbotEnabled; // Đảo trạng thái bật/tắt

            if (isAimbotEnabled) {
                showNotification("🎯 AIMBOT: ĐÃ BẬT", true);
                console.log("Tampermonkey: Aimbot đã BẬT");
            } else {
                showNotification("❌ AIMBOT: ĐÃ TẮT", false);
                console.log("Tampermonkey: Aimbot đã TẮT");
            }
        }
    });

    // Hàm chứa logic hack bắn súng đè lên hàm gốc của game
    function customShootingLogic(t) {
        if (!this.isMouseLocked) return !1;

        var closest = Infinity;
        var closestPlayer = null;

        // 1. Chỉ quét tìm mục tiêu nếu trạng thái Aimbot đang BẬT
        if (isAimbotEnabled && pc.app && pc.app.root.findByName("Game") && pc.app.root.findByName("Game").findByName("PlayerHolder")) {
            var players = pc.app.root.findByName("Game").findByName("PlayerHolder").children;
            var localPlayer = pc.app.root.findByName("Game").findByName("Player");
            if (localPlayer) {
                for(var i = 2; i <= players.length - 1; i++){
                    var currentPlayer = players[i];
                    if (!currentPlayer || !currentPlayer.script || !currentPlayer.script.scripts[0]) continue;
                    var dist = currentPlayer.position.distance(localPlayer.localPosition);
                    if(dist < closest && currentPlayer.script.scripts[0].health != 0){
                        // Kiểm tra nếu cùng team thì bỏ qua không bắn
                        if((currentPlayer.script.scripts[0].team == pc.currentTeam) && currentPlayer.script.scripts[0].team != "none") continue;
                        closest = dist;
                        closestPlayer = currentPlayer;
                    }
                }
            }
        }

        // 2. Logic bắn súng của game
        if ("Melee" == this.currentWeapon.type && this.setMeleeShoot(), "Throwable" == this.currentWeapon.type && this.setThrowShoot(), "Launcher" == this.currentWeapon.type && this.setLauncherShoot(t), this.player.checkShooting(), !this.currentWeapon.isShootable) return !1;
        if (this.leftMouse || this.isShootingLocked || this.isFireStopped || (this.stopFiring(), 0 === this.currentWeapon.ammo && this.reload()), this.leftMouse && !this.isWeaponHidden && !this.isShootingLocked && !this.playerAbilities.isThrowing && this.isReloading < this.timestamp && this.playerAbilities.isHitting < this.timestamp && (this.currentWeapon.ammo > 0 ? this.isShooting = this.currentWeapon.shootTime + this.timestamp : this.reload()), this.isShooting > this.timestamp && !this.isShootingLocked) {
            this.currentWeapon.recoil, this.currentWeapon.cameraShake, Math.random(), Math.random(), this.currentWeapon.spread;
            var i = Math.cos(110 * this.spreadCount);
            this.currentWeapon.spread;
            this.cancelInspect(!0), this.isFocusing && "Rifle" == this.currentWeapon.type && (-.05, .5, -.2, .5, .05, this.currentWeapon.focusSpread, this.currentWeapon.focusSpread * i), "Sniper" != this.currentWeapon.type && "Shotgun" != this.currentWeapon.type || (this.spreadNumber = this.currentWeapon.spread, this.isFocusing && (this.spreadNumber = this.currentWeapon.focusSpread), -5, 5.2), this.currentWeapon.shoot(), this.currentWeapon.isAutomatic || (this.isMouseReleased = !1, this.leftMouse = !1);
            var e = this.currentWeapon.bulletPoint.getPosition().clone(), s = this.currentWeapon.bulletPoint.getEulerAngles().clone();
            "Sniper" == this.currentWeapon.type && this.isFocusing || (this.app.fire("EffectManager:Bullet", e, s), this.entity.script.weaponManager.triggerShooting());
            var o = this.currentWeapon.muzzlePoint.getPosition().clone(), n = this.raycastShootFrom, a = Math.random() * this.spreadNumber - Math.random() * this.spreadNumber, h = Math.random() * this.spreadNumber - Math.random() * this.spreadNumber, r = Math.random() * this.spreadNumber - Math.random() * this.spreadNumber;

            // 3. Xử lý tọa độ đạn: Nếu tìm thấy địch (và đang BẬT aimbot) thì ép đạn bay thẳng vào ngực/đầu, không thì bắn bình thường
            var p;
            if (closestPlayer && isAimbotEnabled) {
                p = new pc.Vec3(closestPlayer.position.x, closestPlayer.position.y + 1.5 + Math.random()/10, closestPlayer.position.z);
            } else {
                p = this.raycastTo.clone().add(new pc.Vec3(a, h, r)); // Bắn bình thường nếu không thấy địch hoặc tính năng đang tắt
            }
            var c = this.currentWeapon.damage, m = this.currentWeapon.distanceMultiplier;
            if ("Shotgun" == this.currentWeapon.type) {
                this.app.fire("EffectManager:Fire", n, p, o, this.player.playerId, c, "Shotgun", m);
                for (var u = 1, l = 0; l < 10; l++) {
                    l > 5 && (u = .5), a = Math.cos(l / 3 * Math.PI) * this.spreadNumber * u, h = Math.sin(l / 3 * Math.PI) * this.spreadNumber * u, r = Math.cos(l / 3 * Math.PI) * this.spreadNumber * u;
                    if (closestPlayer && isAimbotEnabled) {
                        p = new pc.Vec3(closestPlayer.position.x, closestPlayer.position.y + 2 + Math.random()/10, closestPlayer.position.z);
                    } else {
                        p = this.raycastTo.clone().add(new pc.Vec3(a, h, r));
                    }
                    this.app.fire("EffectManager:Fire", n, p, o, this.player.playerId, c, "Shotgun", m);
                }
            } else {
                this.app.fire("EffectManager:Fire", n, p, o, this.player.playerId, c);
            }
            this.setShakeAnimation(t), this.isShootingLocked = !0, this.isFireStopped = !1;
        }
        this.isShooting < this.timestamp && this.isShootingLocked && (this.isShootingLocked = !1), this.updateShakeAnimation(t);
    }

    // Vòng lặp kiểm tra liên tục (mỗi 500 mili-giây) để duy trì việc nạp hack
    setInterval(function() {
        if (typeof pc !== 'undefined' && pc.controls && pc.controls.setShooting) {
            // Nếu phát hiện hàm setShooting bị phục hồi về hàm gốc (không khớp với customShootingLogic)
            if (pc.controls.setShooting !== customShootingLogic) {
                console.log("Tampermonkey: Phát hiện đổi trận/reset game, tiến hành nạp lại Hack...");
                pc.controls.setShooting = customShootingLogic;
            }
        }
    }, 500);

})();
