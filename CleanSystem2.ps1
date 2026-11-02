# =====================================================================
# CleanSystem2.ps1
# Tong hop: Tat Windows Update/Driver Update, tat Startup, Disk Cleanup,
# tat Telemetry/Bloat co ban (tham khao Win10-Initial-Setup-Script cua
# Disassembler0 / alirobe), va hoi mo WinUtil (christitus.com/win) o cuoi.
#
# Nguon tham khao cac ham tweak: 
# https://github.com/Disassembler0/Win10-Initial-Setup-Script
# https://github.com/ChrisTitusTech/winutil
# =====================================================================

# ---------- 0. Tu nang quyen Admin ----------
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Dang yeu cau quyen Administrator..." -ForegroundColor Yellow
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Start-Process powershell -Verb RunAs -ArgumentList $arguments
    exit
}

Write-Host "=== Da co quyen Administrator, bat dau xu ly ===" -ForegroundColor Green
$ErrorActionPreference = "SilentlyContinue"

# =====================================================================
# 1. TAT WINDOWS UPDATE + DRIVER UPDATE
# =====================================================================
Write-Host "`n--- [1/8] Dang tat Windows Update va Driver Update ---" -ForegroundColor Cyan

Stop-Service -Name wuauserv -Force
Set-Service -Name wuauserv -StartupType Disabled
Write-Host "Da tat dich vu wuauserv (Windows Update)"

Stop-Service -Name WaaSMedicSvc -Force
Set-Service -Name WaaSMedicSvc -StartupType Disabled
Write-Host "Da tat dich vu WaaSMedicSvc"

Stop-Service -Name BITS -Force
Set-Service -Name BITS -StartupType Disabled
Write-Host "Da tat dich vu BITS"

$wuPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$auPolicyPath = "$wuPolicyPath\AU"
New-Item -Path $wuPolicyPath -Force | Out-Null
New-Item -Path $auPolicyPath -Force | Out-Null
Set-ItemProperty -Path $auPolicyPath -Name "NoAutoUpdate" -Value 1 -Type DWord
Set-ItemProperty -Path $auPolicyPath -Name "AUOptions" -Value 1 -Type DWord
Set-ItemProperty -Path $auPolicyPath -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Type DWord
Set-ItemProperty -Path $auPolicyPath -Name "AUPowerManagement" -Value 0 -Type DWord
Set-ItemProperty -Path $wuPolicyPath -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -Type DWord

# Chan driver update (tham khao ham DisableUpdateDriver trong Win10-Initial-Setup-Script)
$deviceMetadataPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"
$driverSearchPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching"
New-Item -Path $deviceMetadataPath -Force | Out-Null
New-Item -Path $driverSearchPath -Force | Out-Null
Set-ItemProperty -Path $deviceMetadataPath -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
Set-ItemProperty -Path $driverSearchPath -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
Set-ItemProperty -Path $driverSearchPath -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
Set-ItemProperty -Path $driverSearchPath -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
Write-Host "Da chan driver update qua Windows Update"

# Tat cac scheduled task lien quan update
$updateTasks = @(
    "\Microsoft\Windows\WindowsUpdate\Scheduled Start",
    "\Microsoft\Windows\WindowsUpdate\Automatic App Update",
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan",
    "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task",
    "\Microsoft\Windows\UpdateOrchestrator\Reboot",
    "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker"
)
foreach ($task in $updateTasks) {
    Disable-ScheduledTask -TaskPath (Split-Path $task) -TaskName (Split-Path $task -Leaf) | Out-Null
}
Write-Host "Hoan tat tat Windows Update / Driver Update." -ForegroundColor Green

# =====================================================================
# 2. TAT TELEMETRY, TRACKING, FEEDBACK CO BAN (tham khao script upload)
# =====================================================================
Write-Host "`n--- [2/8] Dang tat Telemetry / Tracking co ban ---" -ForegroundColor Cyan

# Disable Telemetry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Disable-ScheduledTask -TaskName "Microsoft Compatibility Appraiser" -TaskPath "\Microsoft\Windows\Application Experience\" | Out-Null
Disable-ScheduledTask -TaskName "ProgramDataUpdater" -TaskPath "\Microsoft\Windows\Application Experience\" | Out-Null
Disable-ScheduledTask -TaskName "Consolidator" -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" | Out-Null
Disable-ScheduledTask -TaskName "UsbCeip" -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" | Out-Null
Write-Host "Da tat Telemetry"

# Disable Diagnostics Tracking Service (DiagTrack)
Stop-Service "DiagTrack"
Set-Service "DiagTrack" -StartupType Disabled
Write-Host "Da tat DiagTrack"

# Disable WAP Push Service
Stop-Service "dmwappushservice"
Set-Service "dmwappushservice" -StartupType Disabled

# Disable Feedback
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1

# Disable Advertising ID
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1

# Disable App Suggestions / Consumer Features
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0

Write-Host "Hoan tat tat Telemetry / Tracking co ban." -ForegroundColor Green

# =====================================================================
# 3. TAT STARTUP (khoi dong cung Windows) - CHI GIU LAI "UniKey"
# =====================================================================
Write-Host "`n--- [3/8] Dang xu ly Startup: chi giu lai 'UniKey', tat het cac muc khac ---" -ForegroundColor Cyan

# Danh sach tu khoa duoc PHEP giu lai (khong tat). Them ten vao day neu muon giu them.
$startupWhitelist = @("unikey")

function Test-InStartupWhitelist($name, $command) {
    foreach ($kw in $startupWhitelist) {
        if ($name -match $kw -or $command -match $kw) { return $true }
    }
    return $false
}

# --- 3.1 Xu ly cac Registry Run key (HKCU + HKLM, 32-bit va 64-bit) ---
foreach ($path in @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run"
)) {
    if (Test-Path $path) {
        $props = Get-ItemProperty -Path $path
        $names = $props.PSObject.Properties.Name | Where-Object { $_ -notmatch "^PS(Path|ParentPath|ChildName|Provider)$" }
        foreach ($n in $names) {
            $value = $props.$n
            if (Test-InStartupWhitelist $n $value) {
                Write-Host "Giu lai startup entry (whitelist): $n -> $value" -ForegroundColor DarkCyan
                continue
            }
            $backupPath = "$path\_DisabledBackup"
            New-Item -Path $backupPath -Force | Out-Null
            Set-ItemProperty -Path $backupPath -Name $n -Value $value -Force
            Remove-ItemProperty -Path $path -Name $n
            Write-Host "Da tat startup entry: $n -> $value"
        }
    }
}

# --- 3.2 Xu ly cac shortcut trong thu muc Startup (ca User va All Users) ---
# vi du OneDrive, Tailscale co the tao shortcut .lnk trong day thay vi dung Run key
$startupFolders = @(
    [Environment]::GetFolderPath("Startup"),                         # User Startup
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" # All Users Startup
)

foreach ($folder in $startupFolders) {
    if (Test-Path $folder) {
        $shortcuts = Get-ChildItem -Path $folder -Filter "*.lnk" -ErrorAction SilentlyContinue
        foreach ($sc in $shortcuts) {
            if (Test-InStartupWhitelist $sc.BaseName $sc.FullName) {
                Write-Host "Giu lai shortcut Startup (whitelist): $($sc.Name)" -ForegroundColor DarkCyan
                continue
            }
            $disabledFolder = Join-Path $folder "_DisabledBackup"
            New-Item -Path $disabledFolder -ItemType Directory -Force | Out-Null
            Move-Item -Path $sc.FullName -Destination $disabledFolder -Force
            Write-Host "Da chuyen shortcut Startup ra khoi kich hoat: $($sc.Name)"
        }
    }
}

# --- 3.3 Xu ly StartupApproved (trang thai Enable/Disable trong Task Manager > Startup) ---
# Neu mot muc van con o day nhung o trang thai "da tat" tren UI, dam bao no dung la disabled
$approvedPaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
)
foreach ($apPath in $approvedPaths) {
    if (Test-Path $apPath) {
        $apProps = Get-ItemProperty -Path $apPath
        $apNames = $apProps.PSObject.Properties.Name | Where-Object { $_ -notmatch "^PS(Path|ParentPath|ChildName|Provider)$" }
        foreach ($an in $apNames) {
            if (Test-InStartupWhitelist $an "") { continue }
            # Gia tri byte dau tien = 03 nghia la Disabled, 02 la Enabled (theo dinh dang cua Windows)
            $disabledValue = [byte[]](3,0,0,0,0,0,0,0,0,0,0,0)
            Set-ItemProperty -Path $apPath -Name $an -Type Binary -Value $disabledValue -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Hoan tat xu ly Startup: chi con 'UniKey' duoc phep chay cung Windows." -ForegroundColor Green

# =====================================================================
# 4. TAT HIBERNATE
# =====================================================================
Write-Host "`n--- [4/8] Dang tat Hibernate ---" -ForegroundColor Cyan
powercfg /hibernate off
Write-Host "Da tat Hibernate (powercfg /hibernate off)" -ForegroundColor Green

# =====================================================================
# 5. CHINH VISUAL EFFECTS (Custom) - chi giu "Show thumbnails instead
#    of icons" va "Smooth edges of screen fonts", tat het cac hieu ung
#    con lai - giong hinh Performance Options ban gui
# =====================================================================
Write-Host "`n--- [5/8] Dang chinh Visual Effects (Custom, toi uu hieu nang) ---" -ForegroundColor Cyan

$advPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$desktopPath = "HKCU:\Control Panel\Desktop"
$metricsPath = "HKCU:\Control Panel\Desktop\WindowMetrics"
$vfxPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
$dwmPath = "HKCU:\Software\Microsoft\Windows\DWM"

New-Item -Path $vfxPath -Force | Out-Null
Set-ItemProperty -Path $vfxPath -Name "VisualFXSetting" -Type DWord -Value 3   # Custom

# Tat cac hieu ung (bo check)
Set-ItemProperty -Path $desktopPath -Name "DragFullWindows" -Type String -Value 0          # Show window contents while dragging
Set-ItemProperty -Path $desktopPath -Name "MenuShowDelay" -Type String -Value 0            # Fade/slide menus vao view
Set-ItemProperty -Path $metricsPath -Name "MinAnimate" -Type String -Value 0               # Animate windows minimize/maximize
Set-ItemProperty -Path $advPath -Name "TaskbarAnimations" -Type DWord -Value 0             # Animations in taskbar
Set-ItemProperty -Path $advPath -Name "ListviewAlphaSelect" -Type DWord -Value 0           # Fade out menu items / translucent selection
Set-ItemProperty -Path $advPath -Name "ListviewShadow" -Type DWord -Value 0                # Show shadows under mouse pointer / windows
Set-ItemProperty -Path $advPath -Name "TaskbarMn" -Type DWord -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $advPath -Name "IconsOnly" -Type DWord -Value 0                     # 0 = KHONG dung icon only -> giu Thumbnails (checked)
Set-ItemProperty -Path $dwmPath -Name "EnableAeroPeek" -Type DWord -Value 0                # Enable Peek

# Giu lai 2 muc duoc check trong hinh:
# - Show thumbnails instead of icons -> IconsOnly = 0 (da set o tren)
# - Smooth edges of screen fonts -> FontSmoothing = 2 (ClearType)
Set-ItemProperty -Path $desktopPath -Name "FontSmoothing" -Type String -Value 2
Set-ItemProperty -Path $desktopPath -Name "FontSmoothingType" -Type DWord -Value 2

# UserPreferencesMask tuong ung Custom voi 2 muc trên duoc bat, con lai tat
Set-ItemProperty -Path $desktopPath -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00))

Write-Host "Da chinh Visual Effects: chi giu 'Show thumbnails instead of icons' va 'Smooth edges of screen fonts'." -ForegroundColor Green
Write-Host "(Luu y: can dang xuat/khoi dong lai Explorer de ap dung day du)" -ForegroundColor DarkYellow

# =====================================================================
# 6. HOI VA XU LY SYSTEM RESTORE
# =====================================================================
Write-Host "`n--- [6/8] System Restore ---" -ForegroundColor Cyan
$restoreAnswer = Read-Host "Ban co muon XOA cac System Restore Point hien co VA TAT System Restore khong? (Y/N)"

if ($restoreAnswer -match '^(?i)y(es)?$') {
    Write-Host "Dang xoa cac Restore Point hien co..." -ForegroundColor Yellow
    try {
        vssadmin delete shadows /for=$env:SystemDrive /all /quiet | Out-Null
    } catch {}
    Write-Host "Dang tat System Restore tren o $env:SystemDrive..." -ForegroundColor Yellow
    try {
        Disable-ComputerRestore -Drive "$env:SystemDrive\"
    } catch {
        # Fallback qua registry neu Disable-ComputerRestore khong kha dung
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" -Name "DisableSR" -Type DWord -Value 1 -Force
    }
    Write-Host "Da xoa Restore Point va tat System Restore." -ForegroundColor Green
} else {
    Write-Host "Giu nguyen System Restore, khong xoa gi." -ForegroundColor Yellow
}

# =====================================================================
# 7. TAT SYSMAIN (Superfetch) VA CAC SERVICE KHONG PHAI CUA MICROSOFT
#    (giong tab Services trong msconfig, giu lai dong dau tien lien
#     quan Touchpad de khong lam mat chuc nang touchpad)
# =====================================================================
Write-Host "`n--- [7/8] Dang tat SysMain va cac dich vu khong phai Microsoft ---" -ForegroundColor Cyan

# Tat SysMain (Superfetch)
Stop-Service -Name "SysMain" -Force
Set-Service -Name "SysMain" -StartupType Disabled
Write-Host "Da tat dich vu SysMain (Superfetch)"

# Danh sach tu khoa loai tru - KHONG tat cac service co ten khop (vi du: Touchpad/HID)
# Dua theo hinh vi du: "AlpsAlpine HID Monitor Service" can duoc GIU LAI (dong dau tien, van dang Running)
$excludeKeywords = @("touchpad", "hid monitor", "alps", "synaptics", "elan")

$allServices = Get-CimInstance -ClassName Win32_Service | Where-Object { $_.PathName }

foreach ($svc in $allServices) {
    # Bo qua neu ten/display name khop tu khoa loai tru (giu lai vi anh huong toi touchpad)
    $isExcluded = $false
    foreach ($kw in $excludeKeywords) {
        if ($svc.Name -match $kw -or $svc.DisplayName -match $kw) {
            $isExcluded = $true
            break
        }
    }
    if ($isExcluded) {
        Write-Host "Giu lai (lien quan Touchpad/HID): $($svc.DisplayName)" -ForegroundColor DarkCyan
        continue
    }

    # Lay duong dan file thuc thi de kiem tra chu ky so (signature)
    $exePath = $svc.PathName -replace '^\s*"?([^"]+\.exe)"?.*$', '$1'
    $isMicrosoft = $false
    if (Test-Path $exePath -ErrorAction SilentlyContinue) {
        try {
            $sig = Get-AuthenticodeSignature -FilePath $exePath -ErrorAction SilentlyContinue
            if ($sig.SignerCertificate -and $sig.SignerCertificate.Subject -match "Microsoft") {
                $isMicrosoft = $true
            }
        } catch {}
    }

    # Neu KHONG phai cua Microsoft -> tat (giong "Disable all" trong msconfig sau khi da "Hide all Microsoft services")
    if (-not $isMicrosoft) {
        try {
            Set-Service -Name $svc.Name -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name $svc.Name -Force -ErrorAction SilentlyContinue
            Write-Host "Da tat dich vu (non-Microsoft): $($svc.DisplayName)"
        } catch {}
    }
}

Write-Host "Hoan tat tat SysMain va cac dich vu khong phai Microsoft (da giu lai dich vu Touchpad/HID)." -ForegroundColor Green

# =====================================================================
# 8. DISK CLEANUP TOAN BO
# =====================================================================
Write-Host "`n--- [8/8] Dang chay Disk Cleanup toan bo ---" -ForegroundColor Cyan

$cleanupKeyBase = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
$sageNumber = 65535

if (Test-Path $cleanupKeyBase) {
    Get-ChildItem -Path $cleanupKeyBase | ForEach-Object {
        New-ItemProperty -Path $_.PSPath -Name "StateFlags$($sageNumber.ToString('0000'))" -Value 2 -PropertyType DWord -Force | Out-Null
    }
}
Write-Host "Dang chay Disk Cleanup, vui long doi..."
Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:$sageNumber" -Wait
Write-Host "Hoan tat Disk Cleanup." -ForegroundColor Green

# =====================================================================
# 5. TOM TAT
# =====================================================================
Write-Host "`n=== HOAN TAT TOAN BO QUA TRINH ===" -ForegroundColor Green
Write-Host "- Windows Update / Driver Update: DA TAT"
Write-Host "- Telemetry / Tracking / Feedback: DA TAT"
Write-Host "- Chuong trinh khoi dong cung Windows: DA TAT"
Write-Host "- Hibernate: DA TAT"
Write-Host "- Visual Effects: DA CHINH VE CUSTOM (chi giu Thumbnails + Smooth font)"
Write-Host "- System Restore: TUY THEO LUA CHON CUA BAN O TREN"
Write-Host "- SysMain + cac dich vu non-Microsoft: DA TAT (giu lai Touchpad/HID)"
Write-Host "- Disk Cleanup: DA CHAY XONG"

# =====================================================================
# 6. HOI CO MUON MO WINUTIL (christitus.com/win) DE TOI UU THEM KHONG
# =====================================================================
Write-Host "`n--------------------------------------------------------" -ForegroundColor Yellow
$answer = Read-Host "Ban co muon mo WinUtil (christitus.com/win) de toi uu he thong them khong? (Y/N)"

if ($answer -match '^(?i)y(es)?$') {
    Write-Host "Dang tai va mo WinUtil..." -ForegroundColor Cyan
    try {
        Start-Process powershell -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -Command `"irm christitus.com/win | iex`""
    } catch {
        Write-Host "Khong the mo WinUtil tu dong. Ban co the tu chay lenh sau trong PowerShell (Admin):" -ForegroundColor Red
        Write-Host "irm christitus.com/win | iex" -ForegroundColor White
    }
} else {
    Write-Host "Bo qua WinUtil. Ket thuc script." -ForegroundColor Yellow
}

Write-Host "`nKhuyen nghi: Khoi dong lai may de cac thay doi co hieu luc hoan toan." -ForegroundColor Yellow
Read-Host "`nNhan Enter de dong cua so nay"
