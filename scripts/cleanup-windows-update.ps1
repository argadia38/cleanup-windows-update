<#
.SYNOPSIS
Membersihkan cache Windows Update untuk maintenance rutin.

.DESCRIPTION
Script ini menghentikan layanan update, menghapus cache, lalu menyalakan kembali layanan. Cocok untuk DevOps dan automation.

.NOTES
Author: Arga DevOps
#>

# Konfigurasi
$updatePath = "$env:WINDIR\SoftwareDistribution\Download"
$webhook = "https://discord.com/api/webhooks/1432262846384701542/KhIMVaPR86HKOmAH6ULvzfKrYqha_vs0XXKsJ4fjMQ8jsTZjGSgoHBIVujvpJiANprtv"

# Fungsi kirim log
function Send-Log($msg) {
    if ($webhook) {
        $payload = @{ content = $msg } | ConvertTo-Json
        Invoke-RestMethod -Uri $webhook -Method Post -Body $payload -ContentType "application/json"
    }
}

# Eksekusi utama
try {
    Stop-Service wuauserv -Force
    Stop-Service bits -Force

    if (Test-Path $updatePath) {
        Remove-Item "$updatePath\*" -Recurse -Force
        Write-Output "✅ File sampah berhasil dihapus."
        Send-Log "✅ Cleanup berhasil dihapus pada $(Get-Date)"
    } else {
        Write-Output "⚠️ Folder tidak ditemukan: $updatePath"
        Send-Log "⚠️ Folder tidak ditemukan: $updatePath"
    }

    Start-Service wuauserv
    Start-Service bits

    Write-Output "Selesai pada $(Get-Date)"
    Send-Log "✅ Cleanup selesai pada $(Get-Date)"
} catch {
    Write-Output "❌ Gagal eksekusi: $_"
    Send-Log "❌ Gagal eksekusi: $_"
}
