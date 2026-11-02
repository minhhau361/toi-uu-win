# ToggleSecondsClock.ps1
# Bat/tat hien thi giay tren dong ho taskbar Windows 10/11
# Tu dong yeu cau quyen Administrator

# --- Kiem tra va tu nang quyen Admin ---
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
    exit
}

$regPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$regName = "ShowSecondsInSystemClock"

function Get-CurrentState {
    if (Test-Path $regPath) {
        $val = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue
        if ($val -and $val.$regName -eq 1) {
            return $true
        }
    }
    return $false
}

function Set-SecondsClock($enable) {
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }
    $value = if ($enable) { 1 } else { 0 }
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $value -Force | Out-Null

    # Restart Explorer de ap dung thay doi ngay
    Stop-Process -Name explorer -Force
    Start-Process explorer.exe
}

function Set-VietnamRegionAnd24h {
    # Dat dinh dang khu vuc (Region Format) thanh Vietnamese (Vietnam) - vi-VN
    Set-WinHomeLocation -GeoId 236   # 236 = Vietnam
    Set-Culture -CultureInfo vi-VN

    # Dat mui gio ve Dong Duong (GMT+7)
    Set-TimeZone -Id "SE Asia Standard Time"

    # Dat ro rang dinh dang gio ve 24h va kieu ngay/thang cua Viet Nam
    Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sShortTime" -Value "HH:mm"
    Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sTimeFormat" -Value "HH:mm:ss"
    Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "iTime" -Value "1"     # 1 = 24 gio
    Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sShortDate" -Value "dd/MM/yyyy"
    Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name "sLongDate" -Value "dddd, dd MMMM, yyyy"

    # Dong bo gio he thong voi may chu thoi gian
    w32tm /resync /force | Out-Null

    # Khoi dong lai Explorer de ap dung
    Stop-Process -Name explorer -Force
    Start-Process explorer.exe
}

# --- Menu tuong tac ---
Clear-Host
Write-Host "=========================================="
Write-Host "  Cong cu tuy chinh Dong ho / Khu vuc"
Write-Host "=========================================="

$state = Get-CurrentState
$stateText = if ($state) { "DANG BAT" } else { "DANG TAT" }
Write-Host "Hien thi giay tren taskbar: $stateText"
Write-Host ""
Write-Host "1. Bat hien thi giay"
Write-Host "2. Tat hien thi giay"
Write-Host "3. Dat Khu vuc = Viet Nam, dinh dang 24h, dong bo gio"
Write-Host "4. Thoat"
Write-Host ""

$choice = Read-Host "Chon (1/2/3/4)"

switch ($choice) {
    "1" {
        Set-SecondsClock $true
        Write-Host "Da BAT hien thi giay. Explorer da duoc khoi dong lai." -ForegroundColor Green
    }
    "2" {
        Set-SecondsClock $false
        Write-Host "Da TAT hien thi giay. Explorer da duoc khoi dong lai." -ForegroundColor Yellow
    }
    "3" {
        Set-VietnamRegionAnd24h
        Write-Host "Da dat Khu vuc = Viet Nam, dinh dang gio 24h, mui gio GMT+7 va dong bo lai gio." -ForegroundColor Cyan
    }
    default {
        Write-Host "Da thoat, khong thay doi gi."
    }
}

Write-Host ""
Read-Host "Nhan Enter de dong cua so nay"
