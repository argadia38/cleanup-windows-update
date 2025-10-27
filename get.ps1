<#
.SYNOPSIS
Entry point online untuk eksekusi cleanup script via GitHub dengan auto-retry dan logging.

.NOTES
Author: Arga DevOps
#>

$scriptUrl = "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-windows-update.ps1"
$tempPath = "$env:TEMP\cleanup.ps1"
$webhook = "https://discord.com/api/webhooks/1432262846384701542/KhIMVaPR86HKOmAH6ULvzfKrYqha_vs0XXKsJ4fjMQ8jsTZjGSgoHBIVujvpJiANprtv"
$maxRetry = 3

function Send-Log($msg) {
    if ($webhook) {
        $payload = @{ content = $msg } | ConvertTo-Json
        Invoke-RestMethod -Uri $webhook -Method Post -Body $payload -ContentType "application/json"
    }
}

$attempt = 0
$success = $false

while (-not $success -and $attempt -lt $maxRetry) {
    $attempt++
    try {
        Write-Output "📥 Percobaan download ke-$attempt"
        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempPath

        Write-Output "🚀 Menjalankan script..."
        & $tempPath

        Send-Log "✅ Cleanup sukses pada percobaan ke-${attempt}: $(Get-Date)"
        $success = $true
    } catch {
        Write-Output "❌ Gagal eksekusi pada percobaan ke-${attempt}: $_"
        Send-Log "❌ Gagal eksekusi pada percobaan ke-${attempt}: $_"
        Start-Sleep -Seconds 5
    }
}

if (-not $success) {
    Write-Output "🚨 Gagal setelah $maxRetry percobaan."
    Send-Log "🚨 Cleanup gagal total setelah $maxRetry percobaan: $(Get-Date)"
}
