@echo off
setlocal EnableExtensions EnableDelayedExpansion
cls
chcp 65001 >nul
title PLATINUM+ OPTIMIZER V9.4

for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
@echo off
mode con: cols=120 lines=55
:: Definizione corretta dei colori ANSI
set "RED=!ESC![38;2;255;0;0m"
set "RESET=!ESC![0m"
set "WHITE=!ESC![97m"
set "GOLD=!ESC![38;2;255;215;0m"

goto menu

:show_logo
cls
<nul set /p="!RED!"
echo. 
echo. 
echo.                        ██████╗░██╗░░░░░░█████╗░████████╗██╗███╗░░██╗██╗░░░██╗███╗░░░███╗  ░░░░░░░ 
echo.                        ██╔══██╗██║░░░░░██╔══██╗╚══██╔══╝██║████╗░██║██║░░░██║████╗░████║  ░░██╗░░ 
echo.                        ██████╔╝██║░░░░░███████║░░░██║░░░██║██╔██╗██║██║░░░██║██╔████╔██║  ██████╗ 
echo.                        ██╔═══╝░██║░░░░░██╔══██║░░░██║░░░██║██║╚████║██║░░░██║██║╚██╔╝██║  ╚═██╔═╝ 
echo.                        ██║░░░░░███████╗██║░░██║░░░██║░░░██║██║░╚███║╚██████╔╝██║░╚═╝░██║  ░░╚═╝░░ 
echo.                        ╚═╝░░░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░░░░╚═╝  ░░░░░░░ 
echo.
echo.                            ░█████╗░██████╗░████████╗██╗███╗░░░███╗██╗███████╗███████╗██████╗░ 
echo.                            ██╔══██╗██╔══██╗╚══██╔══╝██║████╗░████║██║╚════██║██╔════╝██╔══██╗ 
echo.                            ██║░░██║██████╔╝░░░██║░░░██║██╔████╔██║██║░░███╔═╝█████╗░░██████╔╝ 
echo.                            ██║░░██║██╔═══╝░░░░██║░░░██║██║╚██╔╝██║██║██╔══╝░░██╔══╝░░██╔══██╗ 
echo.                            ╚█████╔╝██║░░░░░░░░██║░░░██║██║░╚═╝░██║██║███████╗███████╗██║░░██║ 
echo.                            ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝╚═╝╚══════╝╚══════╝╚═╝░░╚═╝ 
echo.
echo.
echo.                                             !GOLD!«!WHITE! By @STEFANO83223, @Aledect !GOLD!»!RED!
echo. 
exit /b 0

:menu
set "CONFIG_COMPACTOS="
set "DISABLE_WU="
set "DISABLE_STORE="
set "DISABLE_BLUETOOTH="
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║             !WHITE!PLATINUM+ OPTIMIZER!RED!              ║ 
echo.                                     !RED!║                 !WHITE!Version 9.4!RED!                  ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╠══════════════════════════════════════════════╣ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![1]!WHITE! Run Platinum+ Optimizer                !RED!║ 
echo.                                     !RED!║   !GOLD![0]!WHITE! Exit                                   !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
<nul set /p="!RED!Select an option: "
choice /c 10 /n >nul
if errorlevel 2 (
    echo !RED!0!RESET!
    goto exit_app
)
if errorlevel 1 (
    echo !RED!1!RESET!
    goto config_compactos
)
goto menu

:exit_app
<nul set /p="!RESET!"
echo.
echo. Exiting Platinum+ Optimizer...
timeout /t 2 /nobreak >nul
exit /b 0

:config_compactos
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║           !WHITE!OS BINARY (COMPACTOS)!RED!              ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╟══════════════════════════════════════════════╢ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !WHITE!Do you want to disable Binary Compression?!RED! ║ 
echo.                                     !RED!║   !WHITE!(Recommended: Decompress)                  !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![1]!WHITE! Decompress (Never) - No CPU Overhead   !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![2]!WHITE! Compress (Always)  - Save Disk Space   !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![3]!WHITE! Skip               - Keep Current      !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
<nul set /p="!RED!Select an option [1, 2, or 3]: !RESET!"
choice /c 123 /n >nul
if errorlevel 3 (
    echo !GOLD!3 [Skip - Keep Current]!RESET!
    set "CONFIG_COMPACTOS=skip"
    goto config_wu
)
if errorlevel 2 (
    echo !GOLD!2 [Compress - Always]!RESET!
    set "CONFIG_COMPACTOS=always"
    goto config_wu
)
if errorlevel 1 (
    echo !GOLD!1 [Decompress - Never - No CPU Overhead]!RESET!
    set "CONFIG_COMPACTOS=never"
    goto config_wu
)
goto config_compactos

:config_wu
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║         !WHITE!WINDOWS UPDATE CONFIGURATION!RED!         ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╟══════════════════════════════════════════════╢ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !WHITE!Do you want to disable Windows Update?!RED!     ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![1]!WHITE! Yes - Disable Windows Update           !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![2]!WHITE! No  - Keep Windows Update Enabled      !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
<nul set /p="!RED!Select an option [1 or 2]: !RESET!"
choice /c 12yn /n >nul
if errorlevel 4 (
    echo !GOLD!No [Keep Enabled]!RESET!
    set "DISABLE_WU=0"
    goto config_store
)
if errorlevel 3 (
    echo !GOLD!Yes [Disable Windows Update]!RESET!
    set "DISABLE_WU=1"
    goto config_store
)
if errorlevel 2 (
    echo !GOLD!2 [Keep Enabled]!RESET!
    set "DISABLE_WU=0"
    goto config_store
)
if errorlevel 1 (
    echo !GOLD!1 [Disable Windows Update]!RESET!
    set "DISABLE_WU=1"
    goto config_store
)
goto config_wu

:config_store
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║        !WHITE!MICROSOFT STORE CONFIGURATION!RED!         ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╟══════════════════════════════════════════════╢ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !WHITE!Do you want to disable Microsoft Store?!RED!    ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![1]!WHITE! Yes - Disable Microsoft Store          !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![2]!WHITE! No  - Keep Microsoft Store Enabled     !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
<nul set /p="!RED!Select an option [1 or 2]: !RESET!"
choice /c 12yn /n >nul
if errorlevel 4 (
    echo !GOLD!No [Keep Enabled]!RESET!
    set "DISABLE_STORE=0"
    goto config_bluetooth
)
if errorlevel 3 (
    echo !GOLD!Yes [Disable Store]!RESET!
    set "DISABLE_STORE=1"
    goto config_bluetooth
)
if errorlevel 2 (
    echo !GOLD!2 [Keep Enabled]!RESET!
    set "DISABLE_STORE=0"
    goto config_bluetooth
)
if errorlevel 1 (
    echo !GOLD!1 [Disable Store]!RESET!
    set "DISABLE_STORE=1"
    goto config_bluetooth
)
goto config_store

:config_bluetooth
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║           !WHITE!BLUETOOTH CONFIGURATION!RED!            ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╟══════════════════════════════════════════════╢ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !WHITE!Do you want to disable Bluetooth Services?!RED! ║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![1]!WHITE! Yes - Disable Bluetooth Services       !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!║   !GOLD![2]!WHITE! No  - Keep Bluetooth Services Enabled  !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
<nul set /p="!RED!Select an option [1 or 2]: !RESET!"
choice /c 12yn /n >nul
if errorlevel 4 (
    echo !GOLD!No [Keep Enabled]!RESET!
    set "DISABLE_BLUETOOTH=0"
    goto run_tweak
)
if errorlevel 3 (
    echo !GOLD!Yes [Disable Bluetooth Services]!RESET!
    set "DISABLE_BLUETOOTH=1"
    goto run_tweak
)
if errorlevel 2 (
    echo !GOLD!2 [Keep Enabled]!RESET!
    set "DISABLE_BLUETOOTH=0"
    goto run_tweak
)
if errorlevel 1 (
    echo !GOLD!1 [Disable Bluetooth Services]!RESET!
    set "DISABLE_BLUETOOTH=1"
    goto run_tweak
)
goto config_bluetooth

:run_tweak
if not defined CONFIG_COMPACTOS set "CONFIG_COMPACTOS=never"
if not defined DISABLE_WU set "DISABLE_WU=1"
if not defined DISABLE_STORE set "DISABLE_STORE=1"
if not defined DISABLE_BLUETOOTH set "DISABLE_BLUETOOTH=0"
call :show_logo
echo.                                     !RED!╔══════════════════════════════════════════════╗ 
echo.                                     !RED!║            !WHITE!SELECTED CONFIGURATION!RED!            ║ 
echo.                                     !RED!╟══════════════════════════════════════════════╢ 
echo.                                     !RED!║                                              ║ 
if "!CONFIG_COMPACTOS!"=="never"  echo.                                     !RED!║   !WHITE!CompactOS       : !GOLD!DECOMPRESS (NEVER)       !RED!║ 
if "!CONFIG_COMPACTOS!"=="always" echo.                                     !RED!║   !WHITE!CompactOS       : !GOLD!COMPRESS (ALWAYS)        !RED!║ 
if "!CONFIG_COMPACTOS!"=="skip"   echo.                                     !RED!║   !WHITE!CompactOS       : !GOLD!SKIPPED                  !RED!║ 
if "!DISABLE_WU!"=="1"    echo.                                     !RED!║   !WHITE!Windows Update  : !GOLD!DISABLED                 !RED!║ 
if "!DISABLE_WU!"=="0"    echo.                                     !RED!║   !WHITE!Windows Update  : !GOLD!ENABLED                  !RED!║ 
if "!DISABLE_STORE!"=="1" echo.                                     !RED!║   !WHITE!Microsoft Store : !GOLD!DISABLED                 !RED!║ 
if "!DISABLE_STORE!"=="0" echo.                                     !RED!║   !WHITE!Microsoft Store : !GOLD!ENABLED                  !RED!║ 
if "!DISABLE_BLUETOOTH!"=="1" echo.                                     !RED!║   !WHITE!Bluetooth       : !GOLD!DISABLED                 !RED!║ 
if "!DISABLE_BLUETOOTH!"=="0" echo.                                     !RED!║   !WHITE!Bluetooth       : !GOLD!ENABLED (DEFAULT)        !RED!║ 
echo.                                     !RED!║                                              ║ 
echo.                                     !RED!╚══════════════════════════════════════════════╝ 
echo.
echo.!RED!Automated execution of the tweak starting in:!RESET!
timeout /t 5 /nobreak
echo.
<nul set /p="!RED!"


:: =====================================================================
:: 01. DECOMPRESSIONE SISTEMA (COMPACTOS) & BACKUP INIZIALE
:: =====================================================================

if "!CONFIG_COMPACTOS!"=="never" (
    echo Decompressing operating system [CompactOS: never]...
    compact /compactos:never
)
if "!CONFIG_COMPACTOS!"=="always" (
    echo Compressing operating system [CompactOS: always]...
    compact /compactos:always
)
if "!CONFIG_COMPACTOS!"=="skip" (
    echo Skipping CompactOS configuration...
)

reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f
sc config VSS start= demand >nul
sc start VSS >nul
sc config swprv start= demand >nul
sc start swprv >nul 
echo Creating restore point...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Platinum+ Optimizer' -RestorePointType 'MODIFY_SETTINGS'"
reg export HKLM "%USERPROFILE%\Desktop\platinum_backup.reg" /y

:: =====================================================================
:: 02. VARIABILI UTILITY PER REGISTRO
:: =====================================================================

set "MM=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
set "PREFETCH=%MM%\PrefetchParameters"
set "IOSYS=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System"
set "FS=HKLM\SYSTEM\CurrentControlSet\Control\FileSystem"
set "DWM=HKLM\SOFTWARE\Microsoft\Windows\DWM"
set "GD=HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
set "GDS=%GD%\Scheduler"
set "GDMM=%GD%\MemoryManagement"
set "GDPOWER=%GD%\Power"
set "TCP=HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
set "AFD=HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"
set "POWER=HKLM\SYSTEM\CurrentControlSet\Control\Power"
set "CPU0=HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0"
set "GFX_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GPU_CLASS_KEY=%GFX_CLASS%"

:: =====================================================================
:: 03. BCDEDIT - BOOT, HYPERVISOR, TIMER, MEMORIA, SICUREZZA BOOT
:: =====================================================================

:: Timer e orologi di sistema
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1

:: Impostazioni APIC e configurazione boot
bcdedit /set x2apicpolicy enable >nul 2>&1
bcdedit /set configaccesspolicy default >nul 2>&1
bcdedit /set bootmenupolicy standard >nul 2>&1

:: Emergency Management Services off
bcdedit /set ems off >nul 2>&1

:: Ibernazione off via boot
bcdedit /set hibernation off >nul 2>&1

:: TSC sync policy
bcdedit /set tscsyncpolicy enhanced >nul 2>&1

:: Disattiva ibernazione Windows
powercfg -h off >nul 2>&1

:: =====================================================================
:: 04. TELEMETRIA BASE WINDOWS
:: =====================================================================

:: Disattiva telemetria Microsoft a livello policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: =====================================================================
:: 05. MEMORY MANAGEMENT - CACHE, PAGING, POOL, PRIORITA'
:: =====================================================================

:: Cache di sistema grande
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 0 /f

:: Attiva paging executive
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f

:: Priorità zero page thread
reg add "%MM%" /v "ZeroPageThreadPriority" /t REG_DWORD /d 31 /f

:: Priorità memory management
reg add "%MM%" /v "MemoryManagementPriority" /t REG_DWORD /d 1 /f

:: Disattiva throttling memoria
reg add "%MM%" /v "DisableMemoryThrottling" /t REG_DWORD /d 1 /f

:: Disattiva page splitting
reg add "%MM%" /v "DisablePageSplitting" /t REG_DWORD /d 1 /f

:: Disattiva memory scrubbing
reg add "%MM%" /v "DisableMemoryScrubbing" /t REG_DWORD /d 1 /f

:: Second level cache

:: Pool usage maximum
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f

:: Move images
reg add "%MM%" /v "MoveImages" /t REG_DWORD /d 0 /f

:: Feature settings
reg add "%MM%" /v "FeatureSettings" /t REG_DWORD /d 1 /f

:: Non cancellare pagefile allo shutdown
reg add "%MM%" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f

:: Session view/pool sizes
reg add "%MM%" /v "SessionViewSize" /t REG_DWORD /d 192 /f
reg add "%MM%" /v "SessionPoolSize" /t REG_DWORD /d 128 /f
reg add "%MM%" /v "SystemViewSize" /t REG_DWORD /d 24576 /f

:: Protezione scrittura
reg add "%MM%" /v "EnforceWriteProtection" /t REG_DWORD /d 1 /f

:: Trim working set
reg add "%MM%" /v "TrimWorkingSet" /t REG_DWORD /d 0 /f

:: Write watch
reg add "%MM%" /v "WriteWatch" /t REG_DWORD /d 0 /f

:: Map transfer count
reg add "%MM%" /v "MapTransferCount" /t REG_DWORD /d 0 /f

:: Disattiva paging kernel stacks
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

:: Disattiva pool tagging
reg add "%MM%" /v "DisablePoolTagging" /t REG_DWORD /d 1 /f

:: System cache reserve
reg add "%MM%" /v "SystemCacheReserve" /t REG_DWORD /d 1 /f

:: Large page always
reg add "%MM%" /v "LargePageAlways" /t REG_DWORD /d 1 /f

:: Disattiva background scavenging
reg add "%MM%" /v "DisableBackgroundScavenging" /t REG_DWORD /d 1 /f

:: Disattiva VAD cleanup

:: Override mitigazioni (prima impostazione)
reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f

:: Priorità allocazione pool/memoria
reg add "%MM%" /v "PoolAllocationPriority" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "MemoryPriority" /t REG_DWORD /d 1 /f

:: Nonpaged pool maximum
reg add "%MM%" /v "NonPagedPoolMaximum" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria
reg add "%MM%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f

:: Disattiva page combining
reg add "%MM%" /v "EnablePageCombining" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "DisablePageCombining" /t REG_DWORD /d 1 /f

:: NUMA node selection policy
reg add "%MM%" /v "NumaNodeSelectionPolicy" /t REG_DWORD /d 1 /f

:: DRAM power management off
reg add "%MM%" /v "DramPowerManagement" /t REG_DWORD /d 0 /f

:: Disattiva paging driver
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f

:: Priorità applicazioni foreground
reg add "%MM%" /v "PrioritizeForegroundApplications" /t REG_DWORD /d 1 /f

:: Disattiva aging working set
reg add "%MM%" /v "DisableWorkingSetAging" /t REG_DWORD /d 1 /f

:: Disattiva kernel stack paging
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f

:: Large page minimum
reg add "%MM%" /v "LargePageMinimum" /t REG_DWORD /d 0 /f

:: Nonpaged/paged pool sizes
reg add "%MM%" /v "NonPagedPoolSize" /t REG_DWORD /d 0 /f

:: IO page lock limit

:: Pagine minime libere

:: Threshold dirty page system cache
reg add "%MM%" /v "SystemCacheDirtyPageThreshold" /t REG_DWORD /d 81920 /f

:: Evita collisioni large page
reg add "%MM%" /v "AvoidLargePageCollisions" /t REG_DWORD /d 1 /f

:: PAE
reg add "%MM%" /v "PhysicalAddressExtension" /t REG_DWORD /d 1 /f

:: Quote pool
reg add "%MM%" /v "NonPagedPoolQuota" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PagedPoolQuota" /t REG_DWORD /d 0 /f

:: Opzioni avvio system

:: Flag virtualizzazione

:: Cache livelli CPU
reg add "%MM%" /v "FirstLevelDataCache" /t REG_DWORD /d 65536 /f
reg add "%MM%" /v "ThirdLevelDataCache" /t REG_DWORD /d 131072 /f

:: Policy allocazione memoria fisica
reg add "%MM%" /v "PhysicalMemoryAllocationPolicy" /t REG_DWORD /d 0 /f

:: CFG e hot patch off
reg add "%MM%" /v "EnableCfg" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "HotPatch" /t REG_DWORD /d 0 /f

:: Queue depth memoria/controller
reg add "%MM%" /v "McGlobalShortBankQueueDepth" /t REG_DWORD /d 16 /f
reg add "%MM%" /v "McBankQueueDepth" /t REG_DWORD /d 8 /f
reg add "%MM%" /v "McMaxChannelCount" /t REG_DWORD /d 4 /f

:: Disattiva memory patrol scrub
reg add "%MM%" /v "DisableMemoryPatrolScrub" /t REG_DWORD /d 1 /f

:: NUMA cross node access
reg add "%MM%" /v "NumaCrossNodeAccess" /t REG_DWORD /d 2 /f

:: Shared user data
reg add "%MM%" /v "SharedUserData" /t REG_DWORD /d 1 /f

:: Commit limits
reg add "%MM%" /v "MappedCommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "CommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f

:: IO modification
reg add "%MM%" /v "IoModification" /t REG_DWORD /d 0 /f

:: GameMode cache
reg add "%MM%" /v "GameModeCacheSize" /t REG_DWORD /d 1073741824 /f
reg add "%MM%" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "GameModeCachePriority" /t REG_DWORD /d 15 /f

:: =====================================================================
:: 06. PREFETCH / SUPERFETCH / READ-AHEAD
:: =====================================================================

:: Disattiva prefetcher
reg add "%PREFETCH%" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f

:: Disattiva superfetch
reg add "%PREFETCH%" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f

:: Disattiva tracing Superfetch
reg add "%PREFETCH%" /v "SfTracingState" /t REG_DWORD /d 0 /f

:: Disattiva boot trace
reg add "%PREFETCH%" /v "EnableBootTrace" /t REG_DWORD /d 0 /f

:: Disattiva read ahead/seek ahead
reg add "%PREFETCH%" /v "EnableReadAhead" /t REG_DWORD /d 0 /f
reg add "%PREFETCH%" /v "EnableSeekAhead" /t REG_DWORD /d 0 /f

:: Limita read ahead
reg add "%PREFETCH%" /v "MaxReadAheadSize" /t REG_DWORD /d 0 /f

:: Tentativi prefetch
reg add "%PREFETCH%" /v "PrefetchAttempts" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria e page combining anche via PowerShell
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -PageCombining"

:: =====================================================================
:: 07. I/O SYSTEM / STORAGE / NVME / DISK
:: =====================================================================

:: Abilita IoRing
reg add "%IOSYS%" /v "EnableIoRing" /t REG_DWORD /d 1 /f
reg add "%IOSYS%" /v "IoRingMaxSubmitQueueSize" /t REG_DWORD /d 65536 /f

:: Count operations
reg add "%IOSYS%" /v "CountOperations" /t REG_DWORD /d 0 /f

:: Interrupt steering
reg add "%IOSYS%" /v "InterruptSteeringDisabled" /t REG_DWORD /d 0 /f

:: Bypass IO
reg add "%IOSYS%" /v "BypassIosEnable" /t REG_DWORD /d 1 /f

:: Lookaside
reg add "%IOSYS%" /v "DisableLookAside" /t REG_DWORD /d 1 /f

:: Priorità IO
reg add "%IOSYS%" /v "IoPriorityHint" /t REG_DWORD /d 3 /f

:: No workqueue
reg add "%IOSYS%" /v "IoNoWorkQueue" /t REG_DWORD /d 1 /f

:: Disattiva buffering IO
reg add "%IOSYS%" /v "DisableIoBuffering" /t REG_DWORD /d 1 /f

:: Thread library calls
reg add "%IOSYS%" /v "DisableThreadLibraryCalls" /t REG_DWORD /d 1 /f

:: Optimization flags
reg add "%IOSYS%" /v "OptimizationFlags" /t REG_DWORD /d 0x400000 /f

:: Limiti operazioni read/write/other
reg add "%IOSYS%" /v "IoReadOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoWriteOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoOtherOperationLimit" /t REG_DWORD /d 65536 /f

:: Maximum length IO
reg add "%IOSYS%" /v "IOMaximumLength" /t REG_DWORD /d 1048576 /f

:: Page lock limit IO

:: Match deadline IO
reg add "%IOSYS%" /v "IOMatchDeadline" /t REG_DWORD /d 0 /f

:: Storport: transfer length, richieste, priorità
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "MaximumTransferLength" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "NumberOfRequests" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DisableIdleTimeout" /t REG_DWORD /d 1 /f

:: Stornvme: flush cache, priorità, DPC, bypass IO, power idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableWriteCacheBufferFlush" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "BypassIoEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeCommandTimeout" /t REG_DWORD /d 300 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeMaxIoConcurrency" /t REG_DWORD /d 128 /f

:: MSI/Interrupt NVME
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSIXSupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DeviceExecutionMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 31 /f

:: Disk timeout/cache
reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk\Parameters" /v "TimeOutValue" /t REG_DWORD /d 180 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Disk" /v "EnableCache" /t REG_DWORD /d 1 /f

:: Storage control
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "DisableDeleteNotification" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ZeroPoweredNTDisks" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ShortStreakQueuing" /t REG_DWORD /d 1 /f

:: FairShare disk/netfs off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\Disk" /v "EnableFairShare" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\NetFS" /v "EnableFairShare" /t REG_DWORD /d 0 /f

:: FSUTIL: last access, 8.3, MFT zone, encryption/compression
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1
fsutil behavior set mftzone 4
fsutil behavior set encryptpagingfile 0
fsutil behavior set disablecompression 1
fsutil behavior set disableencryption 1
fsutil behavior set memoryusage 2

:: =====================================================================
:: 08. NTFS / FILE SYSTEM
:: =====================================================================

:: Disattiva last access update
reg add "%FS%" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: MFT zone reservation
reg add "%FS%" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f

:: Disattiva nomi 8.3
reg add "%FS%" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f

:: NTFS memory usage
reg add "%FS%" /v "NtfsMemoryUsage" /t REG_DWORD /d 2 /f

:: Contig file alloc size
reg add "%FS%" /v "ContigFileAllocSize" /t REG_DWORD /d 64 /f

:: Disattiva encryption NTFS
reg add "%FS%" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f

:: Tunnel entries
reg add "%FS%" /v "MaximumTunnelEntries" /t REG_DWORD /d 0 /f
reg add "%FS%" /v "MaximumTunnelEntryAgeInSeconds" /t REG_DWORD /d 0 /f

:: Name/path cache
reg add "%FS%" /v "NameCache" /t REG_DWORD /d 512 /f
reg add "%FS%" /v "PathCache" /t REG_DWORD /d 128 /f

:: Long paths enabled
reg add "%FS%" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f

:: ReFS last access
reg add "%FS%" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: Disattiva compressione NTFS
reg add "%FS%" /v "NtfsDisableCompression" /t REG_DWORD /d 1 /f

:: Extended character 8dot3 rename
reg add "%FS%" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 0 /f

:: Disattiva read ahead NTFS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ntfs" /v "DisableReadAhead" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 09. DWM / DXGI / GRAPHICS CORE / FLIP MODEL
:: =====================================================================

:: Use HW draw list
reg add "%DWM%" /v "UseHWDrawList" /t REG_DWORD /d 1 /f

:: Non forzare software D3D
reg add "%DWM%" /v "ForceSoftwareD3D" /t REG_DWORD /d 0 /f

:: Overlay test mode

:: Independent flip
reg add "%DWM%" /v "EnableIndependentFlip" /t REG_DWORD /d 1 /f

:: Machine check
reg add "%DWM%" /v "EnableMachineCheck" /t REG_DWORD /d 0 /f

:: Non ibernare thumbnails
reg add "%DWM%" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f

:: Disattiva window ghosting
reg add "%DWM%" /v "DisableProcessWindowsGhosting" /t REG_DWORD /d 1 /f

:: Max queued buffers
reg add "%DWM%" /v "MaxQueuedBuffers" /t REG_DWORD /d 1 /f

:: Overlay supported
reg add "%DWM%" /v "OverlaySupported" /t REG_DWORD /d 1 /f

:: Force direct flip
reg add "%DWM%" /v "ForceDirectFlip" /t REG_DWORD /d 1 /f

:: Disattiva overlays
reg add "%DWM%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: Hardware scheduling GPU
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "HwSch_QueueDepth" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "HwSch_MaxPendingCommand" /t REG_DWORD /d 1 /f

:: TDR delay
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 10 /f

:: DMA remapping off
reg add "%GD%" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f

:: VSync latency update
reg add "%GD%" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d 1 /f

:: Dirty rectangles off
reg add "%GD%" /v "EnableDirtyRectangles" /t REG_DWORD /d 0 /f

:: Frame queue mode
reg add "%GD%" /v "FrameQueueMode" /t REG_DWORD /d 0 /f

:: Fullscreen optimizations enable
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 1 /f

:: WDDM checks off
reg add "%GD%" /v "DisableWddm2Checks" /t REG_DWORD /d 1 /f

:: Power setting off
reg add "%GD%" /v "PowerSettingEnable" /t REG_DWORD /d 0 /f

:: Async presentation
reg add "%GD%" /v "EnableAsyncPresentation" /t REG_DWORD /d 1 /f

:: Miracast off
reg add "%GD%" /v "PlatformSupportMiracast" /t REG_DWORD /d 0 /f

:: IOMMU usage off
reg add "%GD%" /v "IommuUsage" /t REG_DWORD /d 0 /f

:: D3D12 shared dynamic value management off
reg add "%GD%" /v "D3D12DisableSharedDynamicValueManagement" /t REG_DWORD /d 1 /f

:: Memory encryption off
reg add "%GD%" /v "DisableMemoryEncryption" /t REG_DWORD /d 1 /f

:: Verify driver level off
reg add "%GD%" /v "VerifyDriverLevel" /t REG_DWORD /d 0 /f

:: Max frame latency
reg add "%GD%" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f

:: TDR level
reg add "%GD%" /v "TdrLevel" /t REG_DWORD /d 8 /f

:: Multiplane overlay 3D off
reg add "%GD%" /v "EnableMultiPlaneOverlay3DDIs" /t REG_DWORD /d 0 /f

:: Force direct flip / overlays
reg add "%GD%" /v "ForceDirectFlip" /t REG_DWORD /d 0 /f
reg add "%GD%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: High priority completion
reg add "%GD%" /v "HighPriorityCompletionMode" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "GpuPriorityChangeMode" /t REG_DWORD /d 1 /f

:: DCI control
reg add "%GD%" /v "DCIControl" /t REG_DWORD /d 1 /f

:: DirectStorage force flush off
reg add "%GDMM%" /v "DirectStorageForceFlush" /t REG_DWORD /d 0 /f

:: Scheduler GPU: preemption, priorità, vsync, async compute
reg add "%GDS%" /v "EnableComputePreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "VsyncIdleTimeout" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableVsyncClockGroup" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "GpuPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "PreemptionLevel" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "MicrocodeQueuePriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableMidGfxPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "SchedulePolicy" /t REG_DWORD /d 4 /f
reg add "%GDS%" /v "GpuResourceAccessPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableYield" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnablePreemptiveScheduling" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableCudaContextPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "PollStatusIterations" /t REG_DWORD /d 1 /f

:: Power GPU: dynamic pstate, DPC per core, caching registry off
reg add "%GDPOWER%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "%GDPOWER%" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f

:: DXGKrnl thread priority
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f

:: Direct3D contexts/loader threads
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxContexts" /t REG_DWORD /d 4096 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxLoaderThreads" /t REG_DWORD /d 16 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "ContextReordering" /t REG_DWORD /d 0 /f

:: Driver software only off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f

:: D3D 12/11 clear on allocate off, async compute, PSO eviction off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisablePsoEviction" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\11.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f

:: DirectDraw emulation only off
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulationOnly" /t REG_DWORD /d 0 /f

:: Vulkan validation off
reg add "HKLM\SOFTWARE\Khronos\Vulkan\ImplicitLayers" /v "DisableValidation" /t REG_DWORD /d 1 /f

:: DirectX user GPU preferences
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1" /f

:: =====================================================================
:: 10. GAME DVR / GAME BAR / GAME MODE
:: =====================================================================

:: Disattiva GameDVR e comportamenti correlati
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Priority" /t REG_DWORD /d 1 /f

:: Disattiva cattura app/audio/cursore
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d 1 /f

:: Policy GameDVR off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f

:: GameMode DVR
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeUseNullRenderer" /t REG_DWORD /d 1 /f

:: =====================================================================
:: =====================================================================
:: 11. MMCSS - MULTIMEDIA CLASS SCHEDULER
:: =====================================================================

:: Network throttling index max
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f

:: System responsiveness
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f

:: Priorita MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /t REG_DWORD /d 6 /f

:: Profilo Games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f

:: Profilo Audio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "False" /f

:: Profilo Low Latency
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f

:: =====================================================================
:: 12. NETWORK & TCP/IP STACK OPTIMIZATION
:: =====================================================================

:: --- TCP/IP Stack & Global Network Parameters ---
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
netsh int tcp set global netdma=enabled >nul 2>&1
netsh int ip set global taskoffload=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set supplemental template=custom icw=10 >nul 2>&1
netsh interface isatap set state disabled >nul 2>&1
netsh interface ip set interface ethernet currenthoplimit=64 >nul 2>&1

:: --- Network Adapter Protocol Bindings (Unbind Unused & Legacy Protocols) ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "Disable-NetAdapterBinding -Name '*' -ComponentID 'vmware_bridge','ms_lldp','ms_lltdio','ms_implat','ms_tcpip6','ms_rspndr','ms_server','ms_msclient' -Confirm:$false" >nul 2>&1

:: --- Network Interface Card (NIC) Hardware & Driver Parameters ---
for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "*SpeedDuplex" /s ^| findstr "HKEY"') do (

    :: Buffer Sizes & Packet Processing Queues
    for /f %%i in ('reg query "%%a" /v "*ReceiveBuffers" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*ReceiveBuffers" /t REG_SZ /d "2048" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TransmitBuffers" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TransmitBuffers" /t REG_SZ /d "2048" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*RSS" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*RSS" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*NumRssQueues" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*NumRssQueues" /t REG_SZ /d "2" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PriorityVLANTag" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PriorityVLANTag" /t REG_SZ /d "1" /f >nul 2>&1
    )

    :: Checksum & Large Send Offloads (LSO)
    for /f %%i in ('reg query "%%a" /v "*IPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*IPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*TCPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*TCPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv4" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*UDPChecksumOffloadIPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*UDPChecksumOffloadIPv6" /t REG_SZ /d "3" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv4" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*LsoV2IPv4" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*LsoV2IPv6" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*LsoV2IPv6" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMARPOffload" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PMARPOffload" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*PMNSOffload" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*PMNSOffload" /t REG_SZ /d "1" /f >nul 2>&1
    )

    :: Interrupt Moderation, Flow Control & Latency Optimization
    for /f %%i in ('reg query "%%a" /v "*InterruptModeration" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*InterruptModeration" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ITR" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ITR" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*FlowControl" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*FlowControl" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "TxIntDelay" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "TxIntDelay" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "TxDelay" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "TxDelay" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "DMACoalescing" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "DMACoalescing" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableLLI" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableLLI" /t REG_SZ /d "1" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WaitAutoNegComplete" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WaitAutoNegComplete" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "LogLinkStateEvent" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "LogLinkStateEvent" /t REG_SZ /d "16" /f >nul 2>&1
    )

    :: Energy Efficient Ethernet & Green Power Reduction
    for /f %%i in ('reg query "%%a" /v "*EEE" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*EEE" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AdvancedEEE" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AdvancedEEE" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EEELinkAdvertisement" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EEELinkAdvertisement" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EeePhyEnable" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EeePhyEnable" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableGreenEthernet" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "GigaLite" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "GigaLite" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "AutoPowerSaveModeEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerSavingMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerSavingMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "SavePowerNowEnabled" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "SavePowerNowEnabled" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PowerDownPll" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PowerDownPll" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ReduceSpeedOnPowerDown" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "ULPMode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "ULPMode" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "Ultra Low Power Mode" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "Ultra Low Power Mode" /t REG_SZ /d "Disabled" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "System Idle Power Saver" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "System Idle Power Saver" /t REG_SZ /d "Disabled" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "Link Speed Battery Saver" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "Link Speed Battery Saver" /t REG_SZ /d "Disabled" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "PnPCapabilities" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "PnPCapabilities" /t REG_DWORD /d "24" /f >nul 2>&1
    )

    :: Selective Suspend & Sleep States
    for /f %%i in ('reg query "%%a" /v "Selective Suspend" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "Selective Suspend" /t REG_SZ /d "Disabled" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "Selective Suspend Idle Timeout" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "Selective Suspend Idle Timeout" /t REG_SZ /d "60" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SelectiveSuspend" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*SelectiveSuspend" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*SSIdleTimeout" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*SSIdleTimeout" /t REG_SZ /d "60" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*DeviceSleepOnDisconnect" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f >nul 2>&1
    )

    :: Wake-on-LAN & Standby Power States
    for /f %%i in ('reg query "%%a" /v "*WakeOnMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*WakeOnPattern" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*WakeOnPattern" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnMagicPacketFromS5" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnMagicPacketFromS5" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnLink" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnLink" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeOnSlot" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeOnSlot" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WakeUpModeCap" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WakeUpModeCap" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "S5WakeOnLan" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "S5WakeOnLan" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnableModernStandby" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnableModernStandby" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "*ModernStandbyWoLMagicPacket" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "EnablePME" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "EnablePME" /t REG_SZ /d "0" /f >nul 2>&1
    )
    for /f %%i in ('reg query "%%a" /v "WolShutdownLinkSpeed" ^| findstr "HKEY"') do (
        Reg.exe add "%%i" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >nul 2>&1
    )
) >nul 2>&1

:: =====================================================================
:: 14. USB / INTERRUPT / PCI / CLASS DEVICE
:: =====================================================================

:: USB selective suspend off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f

:: USBXHCI priority/interrupt moderation
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "InterruptModeration" /t REG_DWORD /d 0 /f

:: USBHUB3 priority

:: HidUsb idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HidUsb" /v "IdleEnabled" /t REG_DWORD /d 0 /f

:: USB class idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}" /v "IdleEnable" /t REG_DWORD /d 0 /f

:: Mouse class force high priority
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E96F-E325-11CE-BFC1-08002BE10318}\0000" /v "ForceProcessHighPriority" /t REG_DWORD /d 1 /f

:: Display class MSI/ASPM/latency
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspm" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f

:: PCI MSI/latency/ASPM
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "MessageSignaledInterrupt" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusSolverMaxDepth" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "PerfOptimize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "LinkDisableAspm" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PciBufferSize" /t REG_DWORD /d 64 /f

:: =====================================================================
:: 15. SERVIZI - DISABILITAZIONE TRAMITE SC CONFIG
:: =====================================================================

:: Elenco servizi da disabilitare
set "SC_DISABLED=DiagTrack dmwappushservice WerSvc DPS WdiServiceHost WdiSystemHost PcaSvc diagnosticshub.standardcollector.service diagsvc SysMain RemoteRegistry RemoteAccess WinRM iphlpsvc BDESVC EFS SCardSvr ScDeviceEnum Fax MapsBroker PhoneSvc TapiSrv AJRouter WpcMonSvc ALG EntAppSvc wisvc RetailDemo WMPNetworkSvc StiSvc SensorService SensrSvc SensorDataService XboxGipSvc XblAuthManager XboxNetApiSvc XblGameSave SEMgrSvc uhssvc upfc microsoftedgeupdater microsoftedgeupdatem EsifTelemetryService ipfsvc AeLookupSvc WSAIFabricSvc edgeupdate edgeupdatem DsSvc WarpSvc NvTelemetryContainer Wecsvc NetTcpPortSharing perceptionsimulation spectrum MixedRealityOpenXRSvc BcastDVRUserService icssvc DmEnrollmentSvc embeddedmode GraphicsPerfSvc HvHost IpxlatCfgSvc jhi_service KtmRm LxpSvc McpManagementService MicrosoftEdgeElevationService NetSetupSvc NcdAutoSetup p2pimsvc p2psvc PerfHost pla PolicyAgent PNRPAutoReg PNRPsvc QWAVE RasAuto RasMan RpcLocator shpamsvc smphost SmsRouter SNMPTRAP svsvc TroubleshootingSvc tzautoupdate WebClient WEPHOSTSVC wercplsupport WFDSConMgrSvc WiaRpc WManSvc wmiApSrv WPDBusEnum LicenseManager fhsvc defragsvc TieringEngineService UdkUserSvc Spooler SharedAccess WwanSvc"

for %%S in (%SC_DISABLED%) do (
    sc config %%S start= disabled >nul 2>&1
)

:: Servizi condizionali Microsoft Store (sc config)
if "!DISABLE_STORE!"=="1" (
    sc config InstallService start= disabled >nul 2>&1
    sc config PushToInstall start= disabled >nul 2>&1
) else (
    sc config InstallService start= demand >nul 2>&1
    sc config PushToInstall start= demand >nul 2>&1
)

:: Servizi condizionali Windows Update (sc config)
if "!DISABLE_WU!"=="1" (
    sc config wuauserv start= disabled >nul 2>&1
    sc config dosvc start= disabled >nul 2>&1
    sc config UsoSvc start= disabled >nul 2>&1
    sc config WaaSMedicSvc start= disabled >nul 2>&1
    sc config bits start= disabled >nul 2>&1
) else (
    sc config wuauserv start= demand >nul 2>&1
    sc config dosvc start= demand >nul 2>&1
    sc config UsoSvc start= demand >nul 2>&1
    sc config WaaSMedicSvc start= demand >nul 2>&1
    sc config bits start= demand >nul 2>&1
)

:: Servizi con spazi nel nome
for %%S in ("AMD Crash Defender Service" "AUEPLauncher" "NvTelemetryContainer") do (
    sc config "%%~S" start= disabled >nul 2>&1
)

:: Edge update services delete
sc delete edgeupdate >nul 2>&1
sc delete edgeupdatem >nul 2>&1

:: Servizi da impostare auto/demand/enabled
sc config TabletInputService start= auto >nul 2>&1
sc config TabletInputService start= enabled >nul 2>&1
sc config IntelAudioService start= demand >nul 2>&1
sc config AppXSvc start= demand >nul 2>&1
sc config ClipSVC start= demand >nul 2>&1
sc config camsvc start= auto >nul 2>&1
sc config swprv start= demand >nul 2>&1
sc config SDRSVC start= demand >nul 2>&1
sc config StorSvc start= demand >nul 2>&1
sc config TrkWks start= auto >nul 2>&1
sc config vds start= demand >nul 2>&1
sc config RtkAudioUniversalService start= auto >nul 2>&1
if "!DISABLE_BLUETOOTH!"=="1" (
    net stop bthserv /y >nul 2>&1
    net stop BTAGService /y >nul 2>&1
    net stop BthAvctpSvc /y >nul 2>&1
    sc config bthserv start= disabled >nul 2>&1
    sc config BTAGService start= disabled >nul 2>&1
    sc config BthAvctpSvc start= disabled >nul 2>&1
) else (
    sc config bthserv start= auto >nul 2>&1
    sc config BTAGService start= demand >nul 2>&1
    sc config BthAvctpSvc start= auto >nul 2>&1
)
sc config Themes start= auto >nul 2>&1
sc config FontCache start= auto >nul 2>&1
sc config CDPSvc start= auto >nul 2>&1
sc config CDPUserSvc start= demand >nul 2>&1
sc config W32Time start= demand >nul 2>&1

:: =====================================================================
:: 16. SERVIZI - START VALUE 4 (DISABLED) NEL REGISTRO
:: =====================================================================

:: Stesso elenco servizi: Start=4
for %%S in (%SC_DISABLED%) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

:: Servizi condizionali Microsoft Store nel registro
if "!DISABLE_STORE!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)

:: Servizi condizionali Windows Update nel registro
if "!DISABLE_WU!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dosvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dosvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)

:: Servizi con start diverso
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\swprv" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RtkAudioUniversalService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
if "!DISABLE_BLUETOOTH!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\camsvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: Chiavi offline/temp system presenti nel file originale
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\wlidsvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\WbioSrvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\BcastDVRUserService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: =====================================================================
:: 17. RIMOZIONE APPX / BLOATWARE
:: =====================================================================

:: Svuota cestino
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue"

:: Rimozione pacchetti AppX utente corrente
for %%A in (
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.SkypeApp"
    "Clipchamp.Clipchamp"
    "Microsoft.Bing"
    "Microsoft.OutlookForWindows"
    "Microsoft.DevHome"
    "Microsoft.Windows.DevHome"
    "Microsoft.WebExperiencePack"
    "Microsoft.Windows.Ai.Copilot.Provider"
    "Microsoft.Copilot"
    "MSTeams"
    "Microsoft.MicrosoftEdge.Stable"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
)

:: Rimozione pacchetti AppX per tutti gli utenti
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *OutlookForWindows* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ScreenSketch* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" >nul 2>&1

:: Funzionalità opzionali Windows
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client', 'SMB1Protocol' -NoRestart" >nul 2>&1

:: Defender sample consent
powershell -NoProfile -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

:: =====================================================================
:: 18. LOGMAN / ETL / EVENT LOG
:: =====================================================================

:: Stop logger ETL
logman stop "Microsoft-Windows-Storage-Storport-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" -ets >nul 2>&1
logman stop "Microsoft-Windows-Kernel-Processor-Power" -ets >nul 2>&1
logman stop "Microsoft-Windows-UserModePowerService" -ets >nul 2>&1
logman stop "Microsoft-Windows-Ntfs-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-DeviceSetupManager-Admin" -ets >nul 2>&1
logman stop "Circular Kernel Context Logger" -ets >nul 2>&1
logman stop "UBPM" -ets >nul 2>&1
logman stop "AutoLogger-Diagtrack-Listener" -ets >nul 2>&1
logman stop "NetCore" -ets >nul 2>&1
logman stop "ContextLogger" -ets >nul 2>&1
logman stop "CloudExperienceHost" -ets >nul 2>&1

:: Pulizia log eventi
wevtutil cl System >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl Security >nul 2>&1
wevtutil cl Setup >nul 2>&1

:: Disattiva log specifici
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1

:: =====================================================================
:: 19. OFFICE / EDGE / WEBVIEW2 / TELEMETRIA BROWSER
:: =====================================================================

:: Office telemetry
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "DisconnectedState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "ContentSlotState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f

:: Edge telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\WebView2" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f

:: Chrome background mode
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f

:: Edge update block
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 20. PRIVACY / TELEMETRIA / CONTENT DELIVERY / COPILOT / RECALL
:: =====================================================================

:: Telemetria profonda
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticData" /t REG_DWORD /d 0 /f

:: Advertising info off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

:: Tailored experiences off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesAllowed" /t REG_DWORD /d 0 /f

:: Feedback frequency off
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f

:: Content Delivery Manager off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f

:: Windows AI / Recall / Copilot off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f

:: Bing search off
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Windows Spotlight off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f

:: Cortana off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Activity feed off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f

:: =====================================================================
:: 21. IFEO - DEBUGGER BLOCK / PRIORITA' / LARGE PAGES
:: =====================================================================

:: Blocco telemetria tramite IFEO debugger
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AggregatorHost.exe" /v "Debugger" /t REG_SZ /d "nul" /f

:: Priorità processi sistema/shell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

:: Priorità bassa per update/WMI/spooler
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spoolsv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f



:: Disattiva sensor watchdog
reg add "%POWER%" /v "DisableSensorWatchdog" /t REG_DWORD /d 1 /f

:: Fabric/LCLK clock gating off
reg add "%POWER%" /v "FabricClockGating" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "LclkClockGating" /t REG_DWORD /d 0 /f

:: Processor performance min/max
reg add "%POWER%" /v "ProcessorPerformanceMinimum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximumPolicy" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CpuUtilizationPercentage" /t REG_DWORD /d 100 /f

:: Energy estimation off
reg add "%POWER%" /v "EnergyEstimationDisabled" /t REG_DWORD /d 1 /f

:: Responsive mode
reg add "%POWER%" /v "ResponsiveModeEnabled" /t REG_DWORD /d 1 /f

:: Accelerated hibernate off
reg add "%POWER%" /v "AcceleratedHibernateEnabled" /t REG_DWORD /d 0 /f

:: Energy efficient turbo off
reg add "%POWER%" /v "EnergyEfficientTurbo" /t REG_DWORD /d 0 /f

:: Turbo boost enabled
reg add "%POWER%" /v "TurboBoostEnabled" /t REG_DWORD /d 1 /f

:: C-States off
:: Disattiva CPU Idle / C-States via Powercfg nativo
powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 5d76a269-e800-44e8-a5b7-062e75e9b736 1 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

:: VR ready/VR mode/low latency
reg add "%POWER%" /v "VRReadyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "VRMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyState" /t REG_DWORD /d 2 /f

:: Memory performance/timing
reg add "%POWER%" /v "MemoryPerformanceMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "MemoryTimingOverride" /t REG_DWORD /d 1 /f

:: SOC power states off

:: USB3 power off
reg add "%POWER%" /v "USB3PowerEnable" /t REG_DWORD /d 0 /f

:: S0 auto power down timer off
reg add "%POWER%" /v "S0AutoPowerDownTimer" /t REG_DWORD /d 0 /f

:: CPU compute efficiency
reg add "%POWER%" /v "CpuComputeEfficiencyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "CpuBusyBudgeting" /t REG_DWORD /d 0 /f

:: Unified stack policy
reg add "%POWER%" /v "UnifiedStackPolicy" /t REG_DWORD /d 0 /f

:: Fast S4 off
reg add "%POWER%" /v "FastS4" /t REG_DWORD /d 0 /f

:: Hiberfile off
reg add "%POWER%" /v "HiberFileEnabled" /t REG_DWORD /d 0 /f

:: Power thresholds
reg add "%POWER%\PowerThresholds" /v "AcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "DcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "AcLineStatus" /t REG_DWORD /d 1 /f
reg add "%POWER%\PowerThresholds" /v "BatteryFlag" /t REG_DWORD /d 0 /f

:: Default power scheme values
reg add "%POWER%\PowerSettings" /v "DefaultPowerSchemeValues" /t REG_BINARY /d 000000 /f



:: =====================================================================
:: 30. PERFORMANCE COUNTERS / PERFLIB / ACPI / PARTMGR / WHEA
:: =====================================================================

:: Disable performance counters
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "ForceSingleDPC" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "BufferSize" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "ExtensibleCounters" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009" /v "Collect Timeout" /t REG_DWORD /d 0 /f

:: ACPI MSI/interrupt syntax
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "InterruptSyntax" /t REG_DWORD /d 0 /f

:: Partmgr staggered spin watches
reg add "HKLM\SYSTEM\CurrentControlSet\Services\partmgr" /v "StaggeredSpinWatches" /t REG_DWORD /d 0 /f

:: WHEA polling/offline off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableMCAPolling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableOffline" /t REG_DWORD /d 1 /f


:: MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f

:: GraphicsDrivers / Direct3D
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "DpiMapIommuContiguous" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f

reg add "%GDS%" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "%GDS%" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f

:: Memory Management
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

reg delete "%MM%" /v "ThirdLevelDataCache" /f >nul 2>&1

:: Explorer / ControlPanel
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f

:: PowerCfg GPU
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

:: VBS / HVCI / Credential Guard / System Guard
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v "Enabled" /t REG_DWORD /d 0 /f

:: Fast startup / ibernazione / timer coalescing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f

:: Storage / TRIM / AHCI
fsutil behavior set DisableDeleteNotify 0

reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableHIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableDIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f

:: GameDVR / Fullscreen Optimizations
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f

:: Driver searching off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "InstallEveryDevice" /t REG_DWORD /d 0 /f

:: Quick machine recovery off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Recovery" /v "QuickMachineRecoveryEnabled" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 32A. CONFIGURAZIONE MICROSOFT STORE (INTERATTIVA)
:: =====================================================================

if "!DISABLE_STORE!"=="0" goto :STORE_ENABLED

:STORE_DISABLED
echo [*] Disabling Microsoft Store [preserving AppX for Defender UI]...
net stop InstallService /y >nul 2>&1
net stop PushToInstall /y >nul 2>&1
sc config InstallService start= disabled >nul 2>&1
sc config PushToInstall start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Blocco Windows Store via Policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerAccountStateContent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "StoreDesktopExtension.exe" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im StoreDesktopExtension.exe >nul 2>&1

:: Disattivazione task pianificati Store
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable >nul 2>&1
goto :STORE_COMMON

:STORE_ENABLED
echo [*] Keeping Microsoft Store enabled and functional...
sc config InstallService start= demand >nul 2>&1
sc config PushToInstall start= demand >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 3 /f >nul 2>&1

:: Rimozione restrizioni Store
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /f >nul 2>&1

:: Riattivazione task di installazione Store
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Enable >nul 2>&1

:STORE_COMMON
:: Garanzia: AppXSvc sempre attivo su richiesta per l'interfaccia di Windows Defender (SecHealthUI)
sc config AppXSvc start= demand >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
sc config ClipSVC start= demand >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1

:: =====================================================================
:: 32B. CONFIGURAZIONE WINDOWS UPDATE (INTERATTIVA)
:: =====================================================================

:: Triggers / Telemetry cleanup
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1

if "!DISABLE_WU!"=="0" goto :WU_SHIELD

:WU_LOCKDOWN
echo [*] Disabling Windows Update completely [Full Lock]...
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop dosvc /y >nul 2>&1
net stop usosvc /y >nul 2>&1
net stop WaaSMedicSvc /y >nul 2>&1
net stop stisvc /y >nul 2>&1

rd /s /q %systemroot%\SoftwareDistribution >nul 2>&1
del /f /q %systemroot%\system32\catroot2\*.* >nul 2>&1

sc triggerinfo wuauserv delete >nul 2>&1
sc triggerinfo usosvc delete >nul 2>&1
sc triggerinfo WaaSMedicSvc delete >nul 2>&1
sc triggerinfo bits delete >nul 2>&1
sc triggerinfo stisvc start/disabled >nul 2>&1

sc config wuauserv start= disabled >nul 2>&1
sc config usosvc start= disabled >nul 2>&1
sc config bits start= disabled >nul 2>&1
sc config WaaSMedicSvc start= disabled >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
sc config stisvc start= disabled >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usosvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

:: Pausa aggiornamenti fino al 2099
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpanded" /t REG_DWORD /d 1 /f >nul 2>&1

:: Disattivazione task di aggiornamento
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1

:: Policy di blocco totale Windows Update
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1

:: Blocco ACL per impedire il ripristino automatico dei servizi da parte di Windows
powershell -NoProfile -Command "$services = @('wuauserv', 'stisvc', 'WaaSMedicSvc'); foreach ($service in $services) { $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\' + $service; if (Test-Path $path) { $acl = Get-Acl $path; $arguments = New-Object System.Security.AccessControl.RegistryAccessRule('Everyone', 'FullControl', 'Allow'); $acl.SetAccessRule($arguments); Set-Acl $path $acl; Set-ItemProperty -Path $path -Name 'Start' -Value 4 } }" >nul 2>&1
goto :WU_FINISH

:WU_SHIELD
echo [*] Configuring Windows Update with Anti-Revert Shield...
:: Mantiene o reimposta i servizi essenziali a demand
sc config wuauserv start= demand >nul 2>&1
sc config usosvc start= demand >nul 2>&1
sc config bits start= demand >nul 2>&1
sc config DoSvc start= demand >nul 2>&1
sc config WaaSMedicSvc start= demand >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usosvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
net start wuauserv >nul 2>&1

:: Riabilitazione task di aggiornamento essenziali
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Enable >nul 2>&1

:: Rimozione pausa forzata al 2099
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /f >nul 2>&1

:: Rimozione blocco accesso totale
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1

:: 1. PROTEZIONE ANTI-REVERT DRIVER (GPU, Rete, Audio)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1

:: 2. BLOCCO UPGRADE FORZATI DI VERSIONE (Lock sulla build attuale)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersion" /t REG_DWORD /d 1 /f >nul 2>&1
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^>nul') do (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersionInfo" /t REG_SZ /d "%%a" /f >nul 2>&1
)

:: 3. NOTIFICA PRIMA DEL DOWNLOAD & NESSUN RIAVVIO FORZATO
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1

:: 4. DISATTIVAZIONE P2P SEEDING (Delivery Optimization diretta HTTP)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1

:WU_FINISH

:: =====================================================================
:: 33. HOSTS
:: =====================================================================

:: =====================================================================
:: 34. ONEDRIVE - RIMOZIONE E PULIZIA
:: =====================================================================

if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
)

rd "%USERPROFILE%\OneDrive" /s /q >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /s /q >nul 2>&1

reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-9950-BDF1-DD622415241E}" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F02C1A0D-BE21-4350-88B0-7367FC96EFF3}" /f >nul 2>&1

:: =====================================================================
:: 35. PULIZIA FILE TEMP / CACHE / LOG / PREFETCH / THUMBS
:: =====================================================================

rd /s /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization" >nul 2>&1
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
rd /s /q "%WINDIR%\Logs" >nul 2>&1
rd /s /q "%WINDIR%\Installer\$PatchCache$" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
rd /s /q "%LocalAppData%\Temp" >nul 2>&1
rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*.*" >nul 2>&1
del /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DXCache\*.*" >nul 2>&1

:: Deep cleaning
rd /s /q "%LocalAppData%\Temp\mozilla-temp-files" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\GameDVR" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge" >nul 2>&1
del /s /f /q "C:\Windows\Logs\*.log" >nul 2>&1
del /f /s /q "C:\Windows\inf\*.log" >nul 2>&1
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%AppData%\Mozilla\Firefox\Profiles\*.default\cache2\*" >nul 2>&1
del /q /f /s "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
rd /s /q "%AppData%\Discord\Cache" >nul 2>&1
rd /s /q "%AppData%\Discord\Code Cache" >nul 2>&1
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.tmp" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.log" >nul 2>&1
del /f /s /q "C:\Windows\panther\*.*" >nul 2>&1
rd /s /q "C:\Windows\panther" >nul 2>&1
del /f /q %windir%\inf\setupapi.dev.log >nul 2>&1
del /f /q %windir%\inf\setupapi.setup.log >nul 2>&1
del /f /s /q %windir%\System32\DriverStore\Temp\*.* >nul 2>&1

:: =====================================================================
:: 36. PIANO ALIMENTAZIONE / MONITOR / SLEEP
:: =====================================================================

powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg -setactive SCHEME_CURRENT

:: =====================================================================
:: 37. ATTIVITA' PIANIFICATE - DISABILITAZIONE / ELIMINAZIONE
:: =====================================================================


schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateBrowserReplacementServer" /f >nul 2>&1

schtasks /Delete /TN "Microsoft\Windows\Maps\MapsUpdateTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Maps\MapsToastTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >nul 2>&1

:: =====================================================================
:: 38. LOCALIZZAZIONE / SENSORI / MICROFONO / APP PRIVACY
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f
if "!DISABLE_BLUETOOTH!"=="1" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
) else (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
)

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessMicrophone /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 39. AUTOLOGGER / DIAGTRACK / DEFENDER LOGGER
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NtfsLog" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Application" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Security" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-System" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPTrafficLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Direct3D" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\GraphicsPerf" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\FaultTolerantHeap" /v "Start" /t REG_DWORD /d 0 /f

:: Blocco file ETL DiagTrack
del /f /q "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >nul 2>&1
echo. > "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny SYSTEM:(F) >nul 2>&1
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny "EVERYONE":(F) >nul 2>&1

:: =====================================================================
:: 40. WINDOWS ERROR REPORTING / WER / RELIABILITY / CRASH CONTROL
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "NMICrashDump" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "SendAlert" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "LastAliveStamp" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 41. UI / EXPLORER / UAC / PERSONALIZZAZIONE
:: =====================================================================

:: Desktop menu delay, auto end tasks, timeout app
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "50" /f

:: UAC disattivato
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f

:: Explorer separate process/desktop process
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /t REG_DWORD /d 1 /f

:: Preview pane off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewPane" /t REG_DWORD /d 1 /f

:: Alpha select off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f

:: Track docs off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

:: Mostra estensioni file
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

:: Recent/frequent off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f

:: Tema scuro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f

:: Slideshow skip
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Personalization\DesktopSlideshow" /v "Skip" /t REG_DWORD /d 1 /f

:: Hide SCAMeetNow
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f

:: No low disk space checks
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d 1 /f

:: PCA/AppCompat off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" /v "AITEnable" /t REG_DWORD /d 0 /f

:: GameBar presence writer off
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f

:: Font smoothing
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f

:: Console virtual terminal level off
reg add "HKCU\Console" /v "VirtualTerminalLevel" /t REG_DWORD /d 0 /f

:: Remote assistance off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f

:: Device metadata network off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f

:: Maps auto update off
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f

:: Sensor permission state off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f

:: Background apps photos off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "Disabled" /t REG_DWORD /d 1 /f

:: Notifiche lockscreen/toast/account off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d 0 /f

:: StorageSense policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v "AllowStorageSenseGlobal" /t REG_DWORD /d 1 /f

:: Visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9e3e078012000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 1 /f

:: =====================================================================
:: 42. STORAGE SENSE / SERIALIZE / PAINT DESKTOP VERSION
:: =====================================================================

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "1024" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "2048" /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "04" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "32" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "02" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "128" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "08" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "256" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "WaitForIdleState" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0 /f

:: =====================================================================
:: 43. PAGEFILE / FTH / WDF
:: =====================================================================

:: Pagefile gestito manualmente
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_ComputerSystem' -Property @{AutomaticManagedPagefile=$False}" >nul 2>&1
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_PageFileSetting where Name=\"C:\\pagefile.sys\"' -Property @{InitialSize=8192; MaximumSize=16384}" >nul 2>&1

:: Fault Tolerant Heap off
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CheckPointPeriod" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CrashVelocity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "DisableFTH" /t REG_SZ /d "1" /f

:: WDF diagnostics off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "DbgBreakOnError" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "LogPages" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "VerboseOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Kmdf\Diagnostics" /v "RetrieveVerboseLogs" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 44. BOOT / WINDOWS / PNP / WAIT KILL SERVICE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BootControl" /v "BootProgressAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "NoPopupsOnBoot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DisableTargetDeviceLogging" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DeviceActionRequests" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "8000" /f

:: =====================================================================
:: 45. SERVIZI BLUETOOTH / PERIFERICHE / LEGACY START VALUES
:: =====================================================================
if "!DISABLE_BLUETOOTH!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Csc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ossrs" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\msiserver" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HPOSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MidiSrv" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\whesvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netprofm" /v "Start" /t REG_DWORD /d 3 /f

:: =====================================================================
:: 46. PROCESSOR GENERIC / POWER THROTTLING / IDLE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "EnablePerformanceStates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FrequencyToPerfStateThreshold" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "IdleResidencyDuration" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfBoostState" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ResponsivenessReductionThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdleThread" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveLowOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveHighOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FastThrottle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "LatencyThrottleOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothing" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothingEnabled" /t REG_DWORD /d 0 /f

reg add "%POWER%" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "PlatformRoleOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 47. KERNEL / EXECUTIVE / I/O DEEP TWEAKS
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MaximumDpcStackDepth" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MinimumDpcRate" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "InterruptTimerRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "FastDeadlockReliance" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ParallelProcessorMinimum" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "LFH_Aggressive_Enable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "WorkerFactoryThreadIdleTimeout" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentCommit" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentReserve" /t REG_DWORD /d 16777216 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Heap_ForceLFH" /t REG_DWORD /d 1 /f

:: Priority control IRQ/interrupt separation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ12Priority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "InterruptPrioritySeparation" /t REG_DWORD /d 4 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MinQueueDepth" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueDepth" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueuePolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionAffinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDXGI" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D12" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D11" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D10" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D9" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D8" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D7" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D6" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D5" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectDraw" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectSound" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectInput" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectPlay" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectShow" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectMusic" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DImmediateMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRetainedMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DHardwareAbstractionLayer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DReferenceRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DNullRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRGBRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMMXRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE41" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE42" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX512" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DTBM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DLZCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DPOPCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDRAND" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDSEED" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DADX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMPX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSGX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DCET" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSS" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSB" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSBD" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBPB" /t REG_DWORD /d 0 /f


:: =====================================================================
:: 48. MEMORY MANAGEMENT AGGIUNTIVI / CACHE / HEAP / LFH
:: =====================================================================

reg add "%MM%" /v "SystemCacheLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "VirtualizationFlags" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 49. DISK / NVME CACHE / PARTMGR / SCSI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk" /v "TimeoutValue" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "CacheIsPowerProtected" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Partmgr\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 50. EDGE RIMOZIONE / TASKS / DIRECTORY
:: =====================================================================

powershell -NoProfile -Command "$edgePath = (Get-Item 'C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe').FullName; Start-Process $edgePath -ArgumentList '--uninstall', '--system-level', '--verbose-logging', '--force-uninstall' -Wait" >nul 2>&1

rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1

:: =====================================================================
:: 51. CORTANA RIMOZIONE / WINGET
:: =====================================================================

winget uninstall cortana --accept-source-agreements --accept-package-agreements >nul 2>&1

:: =====================================================================
:: 52. SENSORI / SERVIZIO SENSORI FINALI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 3 /f

:: =====================================================================
:: 53. APPX DEPLOYMENT / CLIPSVC / TOAST FINALI
:: =====================================================================

taskkill /f /im SearchHost.exe >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToSnapshot" /v "OneDriveSetupLogs" /t REG_MULTI_SZ /d "%ProgramFiles%\Microsoft OneDrive\setup\logs\* /s" /f >nul 2>&1

:: =====================================================================
:: 54. DISK PERFORMANCE / VERIFIER RESET
:: =====================================================================

diskperf -N >nul 2>&1
verifier /reset >nul 2>&1



:: =====================================================================
:: --- IFEO: Massima Priorità ai Giochi / programmi  (Espanso) ---
:: =====================================================================


::WinRar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::7zip
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::qemu
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\qemu-system-x86_64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::obs
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f





:: Working set limit BetGame
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BetGame.exe\PerfOptions" /v "WorkingSetLimitInKB" /t REG_DWORD /d 0 /f


:: ===================================================

:: ===================================================
:: FASE 1: RILEVAMENTO CPU
:: ===================================================
set "CPU_VENDOR=Sconosciuto"
set "CPU_MODEL="

for /f "tokens=2,*" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v "VendorIdentifier" 2^>nul ^| findstr /i "VendorIdentifier"') do (
    echo %%B | findstr /i "AuthenticAMD" >nul && set "CPU_VENDOR=AMD"
    echo %%B | findstr /i "GenuineIntel" >nul && set "CPU_VENDOR=INTEL"
)
for /f "tokens=2,*" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v "ProcessorNameString" 2^>nul ^| findstr /i "ProcessorNameString"') do (
    set "CPU_MODEL=%%B"
)

if "!CPU_VENDOR!"=="Sconosciuto" (
    for /f "tokens=*" %%A in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1).Manufacturer" 2^>nul') do (
        echo %%A | findstr /i "AMD" >nul && set "CPU_VENDOR=AMD"
        echo %%A | findstr /i "Intel" >nul && set "CPU_VENDOR=INTEL"
    )
)

if defined CPU_MODEL (
    echo CPU Rilevata: !CPU_VENDOR! [!CPU_MODEL!]
) else (
    echo CPU Rilevata: !CPU_VENDOR!
)

:: ===================================================
:: FASE 2: RILEVAMENTO GPU
:: ===================================================
echo ===================================================
echo FASE 2: RILEVAMENTO GPU
echo ===================================================

set "GPU1_VENDOR=Nessuna"
set "GPU1_NAME="
set "GPU2_VENDOR=Nessuna"
set "GPU2_NAME="
set "HAS_INTEL_GPU=0"
set "HAS_NVIDIA_GPU=0"
set "HAS_AMD_GPU=0"
set /a count=0

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY_"') do (
    set "CURRENT_KEY=%%K"
    set "DEV_VENDOR=Sconosciuto"
    set "DEV_DESC="

    for /f "tokens=2,*" %%A in ('reg query "!CURRENT_KEY!" /v "DriverDesc" 2^>nul ^| findstr /i "DriverDesc"') do set "DEV_DESC=%%B"

    echo !DEV_DESC! | findstr /i "NVIDIA" >nul && set "DEV_VENDOR=NVIDIA"
    echo !DEV_DESC! | findstr /i "Intel" >nul && set "DEV_VENDOR=INTEL"
    echo !DEV_DESC! | findstr /i /c:"AMD" /c:"Radeon" /c:"Advanced Micro Devices" >nul && set "DEV_VENDOR=AMD"

    if "!DEV_VENDOR!"=="Sconosciuto" (
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_10DE" >nul && set "DEV_VENDOR=NVIDIA"
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_8086" >nul && set "DEV_VENDOR=INTEL"
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_1002" >nul && set "DEV_VENDOR=AMD"
    )

    if "!DEV_VENDOR!"=="Sconosciuto" (
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_10DE" >nul && set "DEV_VENDOR=NVIDIA"
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_8086" >nul && set "DEV_VENDOR=INTEL"
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_1002" >nul && set "DEV_VENDOR=AMD"
    )

    if not "!DEV_VENDOR!"=="Sconosciuto" (
        set /a count+=1
        if !count! equ 1 (
            set "GPU1_VENDOR=!DEV_VENDOR!"
            set "GPU1_NAME=!DEV_DESC!"
        )
        if !count! equ 2 (
            set "GPU2_VENDOR=!DEV_VENDOR!"
            set "GPU2_NAME=!DEV_DESC!"
        )
        if "!DEV_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
        if "!DEV_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
        if "!DEV_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
    )
)

if !count! equ 0 (
    for /f "tokens=1,2 delims=;" %%A in ('powershell -NoProfile -Command "Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | ForEach-Object { $_.AdapterCompatibility + ';' + $_.Name }" 2^>nul') do (
        set "PS_COMPAT=%%A"
        set "PS_NAME=%%B"
        set "DEV_VENDOR=Sconosciuto"
        echo !PS_COMPAT! !PS_NAME! | findstr /i "NVIDIA" >nul && set "DEV_VENDOR=NVIDIA"
        echo !PS_COMPAT! !PS_NAME! | findstr /i "Intel" >nul && set "DEV_VENDOR=INTEL"
        echo !PS_COMPAT! !PS_NAME! | findstr /i /c:"AMD" /c:"Radeon" /c:"Advanced Micro Devices" >nul && set "DEV_VENDOR=AMD"
        if not "!DEV_VENDOR!"=="Sconosciuto" (
            set /a count+=1
            if !count! equ 1 (
                set "GPU1_VENDOR=!DEV_VENDOR!"
                set "GPU1_NAME=!PS_NAME!"
            )
            if !count! equ 2 (
                set "GPU2_VENDOR=!DEV_VENDOR!"
                set "GPU2_NAME=!PS_NAME!"
            )
            if "!DEV_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
            if "!DEV_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
            if "!DEV_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
        )
    )
)

if defined GPU1_NAME (
    echo GPU Principale: !GPU1_VENDOR! [!GPU1_NAME!]
) else (
    echo GPU Principale: !GPU1_VENDOR!
)
if not "!GPU2_VENDOR!"=="Nessuna" (
    if defined GPU2_NAME (
        echo GPU Secondaria: !GPU2_VENDOR! [!GPU2_NAME!]
    ) else (
        echo GPU Secondaria: !GPU2_VENDOR!
    )
)
echo ===================================================
echo ESECUZIONE
echo ===================================================

:: ===================================================
:: SEZIONE CPU
:: ===================================================
if "!CPU_VENDOR!"=="INTEL" (

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "L3_Cache_Foreground_Priority" /t REG_DWORD /d 31 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_QoS_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LLC_ForegroundMonopoly" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Scrubber_Disable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_Locality_Strict" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "CStateLimit" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Enable" /t REG_DWORD /d 1 /f


bcdedit /set tscsyncpolicy enhanced

reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AutonomousCurrentLimitDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LatencyToleranceValue" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "RingBusPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "InterruptToleranceValue" /t REG_DWORD /d 0 /f

:: Extra HWP / Speed Shift
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Interrupt_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_PerformanceSetting" /t REG_DWORD /d 1 /f


:: Extra Turbo
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "EnableTurboBoost" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "TurboMode" /t REG_DWORD /d 1 /f

:: Extra Intel PEP / PCIe power saving
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableD3Hot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableL1Substates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableAspm" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Brighten Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Darken Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Enhance Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Preserve Details" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Desired_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Minimum_Performance" /t REG_DWORD /d 8 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Maximum_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Energy_Performance_Preference" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_Activity_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_EPP" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Lowest_Frequency" /t REG_DWORD /d 800 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Highest_Frequency" /t REG_DWORD /d 4200 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Response" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "MaxThrottleCapacity" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "PerfState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "ThermalThrottle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0LidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0ACPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0DCPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Battery" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Thermal" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Fan" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Cooling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Heating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Humidity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Pressure" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Altitude" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Light" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Proximity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Orientation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Location" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Gyroscope" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Accelerometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Magnetometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Compass" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Barometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0AmbientLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0RGBLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0IRLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0UVLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0XRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0GammaRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousPowerStatesDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PerformanceBias" /t REG_DWORD /d 0 /f

reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f


    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_EPP" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "PerfBoostMode" /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AllowThrottling" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "BackgroundPriority" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Activity_Window" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "RootComplex_VC1_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "EnableD3Cold" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f

) else if "!CPU_VENDOR!"=="AMD" (

    rem Nessun comando per ora AMD CPU
)

:: ===================================================
:: ESECUZIONE BLOCCHI GPU TRAMITE SUBROUTINE
:: ===================================================
if "!HAS_INTEL_GPU!"=="1" call :APPLY_INTEL_GPU
if "!HAS_NVIDIA_GPU!"=="1" call :APPLY_NVIDIA_GPU
if "!HAS_AMD_GPU!"=="1" call :APPLY_AMD_GPU

echo.


reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 2 /f
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1
del /f /q /s "%localappdata%\IconCache.db" >nul 2>&1
del /f /q /s "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
net stop FontCache >nul 2>&1
del /f /q /s "%localappdata%\GDIPFONTCACHEV1.dat" >nul 2>&1
net start FontCache >nul 2>&1
start explorer.exe

echo Operazione completata.
timeout /t 2 >nul
shutdown /r /f /t 3
exit /b 0

:: ===================================================
:: SUBROUTINE GPU INTEL
:: ===================================================
:APPLY_INTEL_GPU
echo [GPU-INTEL] Applicazione ottimizzazioni Intel GPU...

set "INTEL_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY"') do (
    set "GPU_KEY=%%K"
    set "IS_MATCH=0"
    reg query "!GPU_KEY!" /v "DriverDesc" 2>nul | findstr /i "Intel" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "HardwareID" 2>nul | findstr /i "VEN_8086" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "MatchingDeviceId" 2>nul | findstr /i "VEN_8086" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="1" (
        set "INTEL_GPU_FOUND=1"
        call :APPLY_INTEL_INSTANCE "!GPU_KEY!"
    )
)

if "!INTEL_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU Intel rilevata nel loop dinamico.
exit /b 0

:APPLY_INTEL_INSTANCE
set "GPU_KEY=%~1"


reg add "%GPU_KEY%" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "%GPU_KEY%" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ApmEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Ignore_Platform_Limits" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GPU_KEY%" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RingBufferSize" /t REG_DWORD /d 1024 /f



reg add "%GPU_KEY%" /v "DisableAsyncFlip" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableTripleBuffering" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "VSyncControl" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PSREnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisableDisplayCaching" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableRC6" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RC6Disable" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDisplayPowerSaving" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDynamicFrequencyScaling" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "MaxGPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "%GPU_KEY%" /v "MinGPUClockFrequency" /t REG_DWORD /d 300 /f
reg add "%GPU_KEY%" /v "GPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "%GPU_KEY%" /v "EnableTurbo" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "DisableFrameBufferCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableLosslessCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableCompression" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "TextureFilteringQuality" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "AntiAliasingMode" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisablePostProcessing" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableVideoProcessing" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableImageProcessing" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDisplayEnhancement" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "DisableAdaptiveContrast" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "AdaptiveContrastEnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisableDynamicContrast" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDynamicBrightness" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableAmbientLightSensor" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableALS" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "DisablePowerState0" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisablePowerState1" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState2" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState3" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState4" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState5" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState6" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState7" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState8" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState9" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState10" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState11" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState12" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState13" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState14" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisablePowerState15" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTableSize" /t REG_DWORD /d 4194304 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePoolSize" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmResourceCacheSize" /t REG_DWORD /d 268435456 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCacheSize" /t REG_DWORD /d 536870912 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCachePolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmEvictionPolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimPolicy" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDeepSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStandby" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableHibernate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerButton" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidClose" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableACPower" /t REG_DWORD /d 1 /f


:: Disabilita Frame Buffer Compression (FBC). 
:: FBC risparmia banda RAM ma usa cicli GPU e aggiunge latenza. Su RAM a 2100MHz, disattivarlo dà frame più stabili e meno stutter.
reg add "%GPU_KEY%" /v "DisableFBC" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f

:: Disabilita Panel Self Refresh (PSR). Il PSR "bufferizza" il pannello per risparmiare, causando micro-stutter e input lag nei giochi.
reg add "%GPU_KEY%" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PSR_Enable" /t REG_DWORD /d 0 /f

:: Disabilita CMAA (Conservative Morphological Anti-Aliasing) a livello di driver.
:: Lascia che sia il gioco a gestire l'AA. Non sprecare i 24 Execution Units (EU) della UHD 620 per post-processing forzato.
reg add "%GPU_KEY%" /v "ConservativeMorphologicalAntiAliasing" /t REG_DWORD /d 0 /f

:: Priorità assoluta per gli Execution Units (EU) e Render Context
reg add "%GPU_KEY%" /v "EuThreadPriority" /t REG_DWORD /d 31 /f
reg add "%GPU_KEY%" /v "RCPriority" /t REG_DWORD /d 31 /f
reg add "%GPU_KEY%" /v "ContextPriority" /t REG_DWORD /d 31 /f

:: Forza il driver a non usare copie DMA indesiderate (riduce overhead CPU/RAM)
reg add "%GPU_KEY%" /v "DisableDMACopy" /t REG_DWORD /d 1 /f

:: Disabilita il risparmio energetico del motore Media/QuickSync (libera banda sul Ring Bus interno della CPU)
reg add "%GPU_KEY%" /v "MediaPowerSaving" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f



reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchPmClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmiLinkPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "DisableValidation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f


reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "%GPU_KEY%" /v "DynamicVidMemoryControl" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "GfxDynamicPState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisplayPowerSavingTechnology" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "EnablePowerGating" /t REG_DWORD /d 0 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ThirdLevelDataCache" /f 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-95c4-324a7d577775\ee12f2c1-9844-474d-987a-928659de2989" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "CmaaEnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "ColorEnhancement" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "EnableDynamicRefreshRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 40 /f

reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "%GPU_KEY%" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "%GPU_KEY%" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "%GPU_KEY%" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "EnableOverclock" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "RenderAheadLimit" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableDMACopy" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "TextureMemorySize" /t REG_DWORD /d 2048 /f
reg add "%GPU_KEY%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "UseLargePages" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "EnableAggressiveMemoryReclaim" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MinFreeMemoryPool" /t REG_DWORD /d 256 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MaxFreeMemoryPool" /t REG_DWORD /d 512 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MemoryPoolPolicy" /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

exit /b 0

:APPLY_NVIDIA_GPU
echo [GPU-NVIDIA] Applicazione ottimizzazioni NVIDIA GPU...

set "VRAM_MB=8192"

for /f "tokens=*" %%A in ('powershell -NoProfile -Command "$gpu = Get-CimInstance Win32_VideoController | Where-Object {$_.Name -match 'NVIDIA'} | Select-Object -First 1; if($gpu) { [math]::Round($gpu.AdapterRAM / 1048576) } else { 8192 }"') do set "VRAM_MB=%%A"

if "!VRAM_MB!"=="" set "VRAM_MB=8192"

echo [GPU-NVIDIA] VRAM rilevata: !VRAM_MB! MB

reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "CoolBits" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "TripleBuffering" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OpenGLShaders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableOptimusBatteryPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OptimusDeleteRenderHint" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableDynamicPstate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NVTweak" /v "DisableOverlay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "EnableGpuHealthCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePerformanceMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f

echo [GPU-NVIDIA] Ricerca dinamica istanze NVIDIA...

set "NVIDIA_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY"') do (
    set "GPU_KEY=%%K"
    set "IS_MATCH=0"

    reg query "!GPU_KEY!" /v "DriverDesc" 2>nul | findstr /i "NVIDIA" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "HardwareID" 2>nul | findstr /i "VEN_10DE" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "MatchingDeviceId" 2>nul | findstr /i "VEN_10DE" >nul && set "IS_MATCH=1"

    if "!IS_MATCH!"=="1" (
        set "NVIDIA_GPU_FOUND=1"
        call :APPLY_NVIDIA_INSTANCE "!GPU_KEY!"
    )
)

if "!NVIDIA_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU NVIDIA rilevata nel loop dinamico.
exit /b 0

:APPLY_NVIDIA_INSTANCE
set "GPU_KEY=%~1"

reg add "%GPU_KEY%" /v "ReBarEnable" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "ReBarSupported" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RmReBarEnable" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableVRAMCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "DedicatedSegmentSize" /t REG_DWORD /d !VRAM_MB! /f
reg add "%GPU_KEY%" /v "RmFbsrPagedDMA" /t REG_DWORD /d 0 /f

reg add "%GPU_KEY%" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "EnableUlps" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "EnableOverclock" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "EnableCEPreemption" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "RMForceMaxPerf" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PreferredPerformanceMode" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "PerfLevelSrc" /t REG_DWORD /d 13107 /f
reg add "%GPU_KEY%" /v "PowerMizerEnable" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RMPcieLinkSpeed" /t REG_DWORD /d 4 /f
reg add "%GPU_KEY%" /v "DisableL1LowPower" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RMDisablePostL2Compression" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RMGC6Feature" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "RMElpgStateOnInit" /t REG_DWORD /d 3 /f
reg add "%GPU_KEY%" /v "RMHdcpKeyglobZero" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "PeerMappingOverride" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RmGspcPerioduS" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "RMCtxswLog" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "RMLogMsg" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "VRRAlwaysOn" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "vrrSmartDetection" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "GsyncCompatible" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "WDDMv21Enable2MPageSupport" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "WDDMv21Enable64KbSysmemSupport" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "WDDMv21Force2MSizeAlignment" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "NvencPreProcBlitDisable" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "NVFBCEnable" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "VideoControl3" /t REG_DWORD /d 1 /f

reg add "%GPU_KEY%" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%" /v "EnableAspm" /t REG_DWORD /d 0 /f
reg add "%GPU_KEY%" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f

reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f

exit /b 0

:: ===================================================
:: SUBROUTINE GPU AMD
:: ===================================================
:APPLY_AMD_GPU
echo [GPU-AMD] Applicazione ottimizzazioni AMD GPU.

Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "SystemTray" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\Software\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\Software\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
exit /b 0
