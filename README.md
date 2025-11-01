# 🧹 Clean Windows Tools

Kumpulan script PowerShell untuk membersihkan cache Windows Update, file sementara, dan mengelola layanan Windows Update. Dirancang untuk membantu pengguna menghemat ruang penyimpanan dan menjaga performa Windows tetap optimal.

![Preview Menu CLI](https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/docs/menu.png)
*(Catatan: Gambar pratinjau mungkin belum menampilkan semua opsi menu terbaru)*

---

## 📦 Fitur Utama

- 🔧 **Cleanup:**
    - Membersihkan cache Windows Update
    - Membersihkan folder temporary (User & Sistem)
    - Menjalankan semua maintenance (Cleanup Update & Temp)
- ⚙️ **Utility:**
    - Cek Status Aktivasi Windows
    - Nonaktifkan layanan Windows Update
    - Aktifkan layanan Windows Update
    - Cek status layanan Windows Update
- 🚀 **Eksekusi:**
    - Menu interaktif yang mudah digunakan
    - Eksekusi online via `irm | iex`

---

## 🚀 Eksekusi Online

Langsung jalankan dari PowerShell (sebagai Administrator):

```powershell
irm "[https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/get.ps1](https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/get.ps1)" | iex ```

---
English:
Clean Windows Tools is a collection of PowerShell scripts to remove Windows Update cache, temporary system files, and manage the Windows Update service. It helps users free up disk space and maintain optimal Windows performance.

(Note: The preview image may not show all the latest menu options)

📦 Key Features
🔧 Cleanup:

Remove Windows Update cache

Clean user and system temporary folders

Run all maintenance (Cleanup Update & Temp)

⚙️ Utilities:

Check Windows Activation Status

Disable Windows Update service

Enable Windows Update service

Check Windows Update service status

🚀 Execution:

Easy-to-use interactive menu

Run online via irm | iex

🚀 Run Online
Execute directly from PowerShell (as Administrator):
```powershell
irm "[https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/get.ps1](https://raw.githubusercontent.com/argadia38/cleanup-windows-update/main/get.ps1)" | iex