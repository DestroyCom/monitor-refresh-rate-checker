param (
    [Parameter(Mandatory = $true)]
    [int]$DisplayId,

    [Parameter(Mandatory = $true)]
    [int]$DesiredRefreshRate,

    # Log file path
    [string]$LogFile = "$env:APPDATA\MonitorRefreshRateChecker\MonitorRefreshRateChecker.log"
)

# Create log file if it doesn't exist
$logDir = Split-Path $LogFile
if (!(Test-Path $logDir)) {
    New-Item -ItemType Directory -Force -Path $logDir | Out-Null
}

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp [$Level] $Message"
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log " "
Write-Log "Start refresh rate check for DisplayId $DisplayId (wanted rate : $DesiredRefreshRate Hz)."

try {
    $display = Get-DisplayInfo -DisplayId $DisplayId
    $displayName = $display.DisplayName
    $currentRefreshRate = [System.Math]::Round($display.Mode.RefreshRate)
    Write-Log "Display $DisplayId ($displayName) : Current refresh rate $currentRefreshRate Hz."

    # Vérifie si le taux de rafraîchissement est en dessous du seuil souhaité
    if ($currentRefreshRate -lt $DesiredRefreshRate) {
        Write-Log "Display $DisplayId ($displayName) : Refresh rate ($currentRefreshRate Hz) below wanted rate ($DesiredRefreshRate Hz). Update in progress..."
        Set-DisplayRefreshRate -DisplayId $DisplayId -RefreshRate $DesiredRefreshRate -AllowChanges
        Write-Log "Display $DisplayId ($displayName) : Refresh rate updated at $DesiredRefreshRate Hz."
    }
    else {
        Write-Log "Display $DisplayId ($displayName) : Refresh rate ($currentRefreshRate Hz) is already at or above wanted rate ($DesiredRefreshRate Hz)."
    }
}
catch {
    Write-Log "Error while checking refresh rate for DisplayId $DisplayId ($displayName) : $_" -Level "ERROR"
    throw $_
}

Write-Log "End refresh rate check for DisplayId $DisplayId ($displayName)."
Write-Log " "
Write-Log "-----------------------------------------------------------------------------------------------------------------"
