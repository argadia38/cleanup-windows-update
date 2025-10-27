<#
.SYNOPSIS
Membungkus eksekusi script dengan auto-retry dan logging ke webhook.

.PARAMETER ScriptPath
Path ke script PowerShell yang ingin dijalankan.

.PARAMETER WebhookUrl
URL webhook untuk kirim status.

.PARAMETER MaxRetry
Jumlah maksimum percobaan ulang jika gagal.

.EXAMPLE
.\auto-retry-wrapper.ps1 -ScriptPath "$env:TEMP\cleanup.ps1" -WebhookUrl "..." -MaxRetry 3
#>

param (
    [string]$ScriptPath,
    [string]$WebhookUrl,
    [int]$MaxRetry = 3
)

function Send-Log($msg) {
    $payload = @{ content = $msg } | ConvertTo-Json
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $payload -ContentType "application/json"
}

$attempt = 0
$success = $false

while (-not $success -and $attempt -lt $MaxRetry) {
    $attempt++
    try {
        Write-Output "🔄 Percobaan ke-${attempt}: $ScriptPath"
        & $ScriptPath
        Send-Log "✅ Sukses eksekusi $ScriptPath pada percobaan ke-${attempt}"
        $success = $true
    } catch {
        Send-Log "❌ Gagal eksekusi $ScriptPath pada percobaan ke-${attempt}: $_"
        Start-Sleep -Seconds 5
    }
}

if (-not $success) {
    Write-Output "🚨 Gagal setelah $MaxRetry percobaan."
}
