// ==UserScript==
// @name         PlayCanvas Aimbot Hack
// @namespace    http://tampermonkey.net
// @version      1.2
// @description  Tự động đổi hướng đạn sang người chơi gần nhất (Aimbot) - Sửa lỗi mất tác dụng khi đổi ván
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

    // Hàm tạo và hiển thị thông báo nhanh trên màn hình (Toast Message)
    function showNotification(message, isSuccess) {
        let notifyDiv = document.getElementById('aimbot-notify');
        if (!notifyDiv) {
            notifyDiv = document.createElement('div');
            notifyDiv.id = 'aimbot-notify';
            notifyDiv.style.position = 'fixed';
            notifyDiv.style.top = '20px';
            notifyDiv.style.right = '20px';
            notifyDiv.style.padding = '12px 24px';
            notifyDiv.style.borderRadius = '8px';
            notifyDiv.style.color = '#ffffff';
            notifyDiv.style.fontFamily = 'Arial, sans-serif';
            notifyDiv.style.fontSize = '16px';
            notifyDiv.style.fontWeight = 'bold';
            notifyDiv.style.zIndex = '99999';
            notifyDiv.style.transition = 'opacity 0.3s ease';
            notifyDiv.style.boxShadow = '0 4px 12px rgba(0,0,0,0.3)';
            document.body.appendChild(notifyDiv);
        }

        // Đổi màu nền: Xanh lá nếu Bật, Đỏ nếu Tắt
        notifyDiv.style.backgroundColor = isSuccess ? '#2ecc71' : '#e74c3c';
        notifyDiv.innerText = message;
        notifyDiv.style.opacity = '1';

        // Tự động ẩn thông báo sau 2 giây
        setTimeout(() => {
            notifyDiv.style.opacity = '0';
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
