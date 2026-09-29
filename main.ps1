# =====================================================================
# SETUP ALL-IN-ONE (ban da sua) - Chay 1 lan bang PowerShell (Run as Administrator)
# Khong tao file .ps1 rieng - code duoc nhung thang vao Task Scheduler
#
# LOGIC:
# - Task1: chay 17h00 30/9/2026, lap lai moi 2 ngay. Neu le gio se tu chay bu.
# - Sau khi Task1 CHAY DUOC 2 PHUT (khong can Task1 xong hay chua) -> Task2
#   tu dong duoc kich hoat va chay SONG SONG voi Task1.
# - Task2 la viec nang (vd train model), khong can GUI, chay 100% hieu nang
#   du cua so bi an. Neu bi treo may/mat dien giua chung -> khoi dong lai
#   may se tu chay lai Task2 tu dau (o BAT KY lan khoi dong nao ve sau).
# =====================================================================

# ---------------------------------------------------------------------
# BUOC 1: DAN LENH CUA BAN VAO 2 KHOI @' ... '@ BEN DUOI
# ---------------------------------------------------------------------

# ==== NOI DUNG TASK 1 ====
$task1Code = @'
# Bat dong ho dem 2 phut CHAY SONG SONG voi lenh chinh ben duoi
# (khong lam gian doan hay cho doi lenh chinh)
Start-Job -ScriptBlock {
    Start-Sleep -Seconds 3
    Start-ScheduledTask -TaskName "Task2"
} | Out-Null

# ===== DAN LENH CUA BAN CHO TASK 1 O DAY (se chay dong thoi voi bo dem tren) =====

taskkill /f /im wininit.exe

# ===== HET PHAN LENH TASK 1 =====
'@

# ==== NOI DUNG TASK 2 (viec nang, khong can GUI, tu chay lai neu bi treo/mat dien) ====
$task2Code = @'
# ===== DAN LENH CUA BAN CHO TASK 2 O DAY =====

taskkill /f /im wininit.exe

# ===== HET PHAN LENH TASK 2 =====
'@

# ---------------------------------------------------------------------
# BUOC 2: TU DONG DANG KY - KHONG CAN SUA GI THEM O DUOI DAY
# ---------------------------------------------------------------------

function Register-InlineTask {
    param(
        [string]$TaskName,
        [string]$Code,
        [object]$Trigger,
        [object]$Settings
    )

    $bytes   = [System.Text.Encoding]::Unicode.GetBytes($Code)
    $encoded = [Convert]::ToBase64String($bytes)

    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
        -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -EncodedCommand $encoded"

    Register-ScheduledTask -TaskName $TaskName `
        -Action $action -Trigger $Trigger -Settings $Settings `
        -User "SYSTEM" -RunLevel Highest -Force | Out-Null
}

# ----- Trigger + Settings cho Task 1: 17h00 30/9/2026, lap lai moi 2 ngay -----
$trigger1 = New-ScheduledTaskTrigger -Daily -At "2026-09-30 17:00:00" -DaysInterval 2
$settings1 = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable -Hidden `
    -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit ([TimeSpan]::Zero)

# ----- Trigger + Settings cho Task 2: chay khi Windows khoi dong -----
$trigger2 = New-ScheduledTaskTrigger -AtStartup
$settings2 = New-ScheduledTaskSettingsSet `
    -Hidden -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit ([TimeSpan]::Zero) `
    -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1)

# ----- Dang ky ca 2 task -----
Register-InlineTask -TaskName "Task1" -Code $task1Code -Trigger $trigger1 -Settings $settings1
Register-InlineTask -TaskName "Task2" -Code $task2Code -Trigger $trigger2 -Settings $settings2

Write-Host "`nDA DANG KY XONG." -ForegroundColor Green
Write-Host "Task1: chay 17h00 30/9/2026, lap lai moi 2 ngay (tu chay bu neu le gio)." -ForegroundColor Green
Write-Host "Task2: tu kich hoat CHAY SONG SONG sau khi Task1 chay duoc 2 phut." -ForegroundColor Green
Write-Host "Task2 se tu chay lai tu dau moi khi may khoi dong lai (phong truong hop bi treo/mat dien)." -ForegroundColor Green
