<#
.SYNOPSIS
Entry point online untuk eksekusi cleanup script via GitHub.

.DESCRIPTION
Script ini akan mendownload dan menjalankan cleanup script dari GitHub, lalu kirim log ke webhook jika diset.

.NOTES
Author: Arga DevOps
#>

$scriptUrl = "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-windows-update.ps1"
$tempPath = "$env:TEMP\cleanup.ps1"
$webhook = "https://discord.com/api/webhooks/1432262846384701542/KhIMVaPR86HKOmAH6ULvzfKrYqha_vs0XXKsJ4fjMQ8jsTZjGSgoHBIVujvpJiANprtv"  # Optional

try {
    Invoke-WebRequest -Uri $scriptUrl -OutFile $tempPath
    Write-Output "📥 Script berhasil di-download."

    & $tempPath

    if ($webhook) {
        $msg = "✅ Cleanup selesai pada $(Get-Date)"
        Invoke-RestMethod -Uri $webhook -Method Post -Body (@{ content = $msg } | ConvertTo-Json) -ContentType "application/json"
    }
} catch {
    Write-Output "❌ Gagal eksekusi: $_"
}
