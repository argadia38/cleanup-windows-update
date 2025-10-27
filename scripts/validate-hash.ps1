<#
.SYNOPSIS
Validasi integritas file dengan hash SHA256.

.PARAMETER FilePath
Path ke file yang ingin dicek.

.PARAMETER ExpectedHash
Hash SHA256 yang diharapkan.

.EXAMPLE
.\validate-hash.ps1 -FilePath "$env:TEMP\cleanup.ps1" -ExpectedHash "ABC123..."
#>

param (
    [string]$FilePath,
    [string]$ExpectedHash
)

if (-not (Test-Path $FilePath)) {
    Write-Output "❌ File tidak ditemukan: $FilePath"
    exit 1
}

$actualHash = Get-FileHash -Path $FilePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash

if ($actualHash -eq $ExpectedHash) {
    Write-Output "✅ Hash valid: $actualHash"
} else {
    Write-Output "⚠️ Hash tidak cocok!"
    Write-Output "Expected: $ExpectedHash"
    Write-Output "Actual:   $actualHash"
    exit 1
}
