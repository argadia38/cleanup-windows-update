<#
.SYNOPSIS
Membersihkan folder temporary user dan sistem.

.DESCRIPTION
Script ini menghapus isi folder %TEMP% dan C:\Windows\Temp untuk maintenance ringan.

.NOTES
Author: Arga DevOps
#>

$paths = @(
    "$env:TEMP\*",
    "C:\Windows\Temp\*"
)

foreach ($path in $paths) {
    try {
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Output "✅ Temp dibersihkan: $path"
        } else {
            Write-Output "⚠️ Path tidak ditemukan: $path"
        }
    } catch {
        Write-Output "❌ Gagal hapus: $path — $_"
    }
}

Write-Output "Selesai pada $(Get-Date)"
