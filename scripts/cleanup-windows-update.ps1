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

# Eksekusi utama
try {
    Stop-Service wuauserv -Force
    Stop-Service bits -Force

    if (Test-Path $updatePath) {
        Remove-Item "$updatePath\*" -Recurse -Force
        Write-Output "✅ File sampah berhasil dihapus."
    } else {
        Write-Output "⚠️ Folder tidak ditemukan: $updatePath"
    }

    Start-Service wuauserv
    Start-Service bits

    Write-Output "Selesai pada $(Get-Date)"
} catch {
    Write-Output "❌ Gagal eksekusi: $_"
}
