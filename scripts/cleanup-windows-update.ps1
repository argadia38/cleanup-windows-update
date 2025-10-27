<#
.SYNOPSIS
Membersihkan cache Windows Update untuk menghemat ruang dan menghindari error update.

.DESCRIPTION
Script ini menghentikan layanan update, menghapus file cache, lalu menyalakan kembali layanan. Cocok untuk maintenance rutin atau integrasi ke workflow automation.

.NOTES
Author: Arga DevOps
Created: 2025-10-27
#>

Write-Output "🧹 Menjalankan cleanup Windows Update..."

# Stop layanan
Stop-Service wuauserv -Force
Stop-Service bits -Force

# Hapus cache
$updatePath = "$env:WINDIR\SoftwareDistribution\Download"
if (Test-Path $updatePath) {
    Remove-Item "$updatePath\*" -Recurse -Force
    Write-Output "✅ File sampah berhasil dihapus."
} else {
    Write-Output "⚠️ Folder tidak ditemukan: $updatePath"
}

# Start layanan
Start-Service wuauserv
Start-Service bits

Write-Output "📅 Selesai pada $(Get-Date)"
