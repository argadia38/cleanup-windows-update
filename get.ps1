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
    Write-Host "[5] Disable Windows Update" -ForegroundColor Red
    Write-Host "[6] Enable Windows Update" -ForegroundColor Green
    Write-Host "[7] Check Windows Update Status" -ForegroundColor Yellow
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
        '5' {
            Write-Host "Mencoba menonaktifkan Windows Update (wuauserv)..." -ForegroundColor Yellow
            try {
                Stop-Service wuauserv -Force -ErrorAction Stop
                Set-Service -Name wuauserv -StartupType Disabled -ErrorAction Stop
                Write-Host "✅ Layanan Windows Update (wuauserv) telah DINONAKTIFKAN." -ForegroundColor Green
            } catch {
                Write-Host "❌ Gagal menonaktifkan layanan: $_" -ForegroundColor Red
            }
        }
        '6' {
            Write-Host "Mencoba mengaktifkan Windows Update (wuauserv)..." -ForegroundColor Yellow
            try {
                Set-Service -Name wuauserv -StartupType Automatic -ErrorAction Stop
                Start-Service wuauserv -ErrorAction Stop
                Write-Host "✅ Layanan Windows Update (wuauserv) telah DIAKTIFKAN (Startup: Automatic)." -ForegroundColor Green
            } catch {
                Write-Host "❌ Gagal mengaktifkan layanan: $_" -ForegroundColor Red
            }
        }
        '7' {
            Write-Host "Mengecek status layanan Windows Update (wuauserv)..." -ForegroundColor Cyan
            try {
                $service = Get-Service -Name wuauserv -ErrorAction Stop
                Write-Host "  Nama Layanan: $($service.Name)"
                Write-Host "  Status        : $($service.Status)"
                Write-Host "  Startup Type  : $($service.StartupType)"

                if ($service.StartupType -eq 'Disabled') {
                    Write-Host "  Kesimpulan    : Layanan Windows Update saat ini DINONAKTIFKAN." -ForegroundColor Red
                } else {
                    Write-Host "  Kesimpulan    : Layanan Windows Update saat ini AKTIF (Startup: $($service.StartupType))." -ForegroundColor Green
                }
            } catch {
                Write-Host "❌ Gagal mendapatkan status layanan: $_" -ForegroundColor Red
            }
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
    # Perbarui rentang pilihan di prompt
    $input = Read-Host "Masukkan pilihan [1-7, 0]"
    Run-Option $input
    Write-Host "`nTekan Enter untuk kembali ke menu..."
    [void][System.Console]::ReadLine()
} while ($true)