<#
.SYNOPSIS
Entry point online untuk eksekusi cleanup script via GitHub.

.DESCRIPTION
Script ini akan mendownload dan menjalankan cleanup script dari GitHub, lalu kirim log ke webhook jika diset.

.NOTES
Author: Arga DevOps
#>

$scriptUrl = "https://raw.githubusercontent.com/arga-devops/windows-tools/main/scripts/cleanup-windows-update.ps1"
$tempPath = "$env:TEMP\cleanup.ps1"
$webhook = "https://your.webhook.url"  # Optional

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
