<#
.SYNOPSIS
Menu CLI untuk eksekusi script maintenance Windows dari repo cleanup-windows-update.

.NOTES
Author: Arga DevOps
#>

function Show-Menu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "  🧰 Cleanup Windows Toolkit" -ForegroundColor Yellow
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[1] Cleanup Windows Update Cache"
    Write-Host "[2] Cleanup Temp Files"
    Write-Host "[3] Run All Maintenance (Run 1 + 2)"
    Write-Host "[4] Check Activation Status"
    Write-Host "[0] Exit"
    Write-Host ""
}

function Run-Option {
    param ($choice)

    switch ($choice) {
        '1' {
            irm "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-windows-update.ps1" | iex
        }
        '2' {
            irm "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-temp.ps1" | iex
        }
        '3' {
            irm "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-windows-update.ps1" | iex
            irm "https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/scripts/cleanup-temp.ps1" | iex
        }
        '4' {
            slmgr /xpr
        }
        '0' {
            Write-Host "`n👋 Keluar dari menu. Sampai jumpa!" -ForegroundColor Green
            exit
        }
        default {
            Write-Host "⚠️ Pilihan tidak valid. Coba lagi." -ForegroundColor Red
        }
    }
}

do {
    Show-Menu
    $input = Read-Host "Masukkan pilihan [1-4, 0]"
    Run-Option $input
    Write-Host "`nTekan Enter untuk kembali ke menu..."
    [void][System.Console]::ReadLine()
} while ($true)
