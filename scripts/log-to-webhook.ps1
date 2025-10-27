<#
.SYNOPSIS
Mengirim log status ke webhook (Discord, Supabase, atau endpoint lain).

.PARAMETER Message
Pesan yang akan dikirim ke webhook.

.PARAMETER WebhookUrl
URL webhook tujuan.

.EXAMPLE
.\log-to-webhook.ps1 -Message "Cleanup selesai" -WebhookUrl "https://your.webhook.url"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$Message,

    [Parameter(Mandatory=$true)]
    [string]$WebhookUrl
)

$payload = @{
    content = $Message
} | ConvertTo-Json

try {
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $payload -ContentType "application/json"
    Write-Output "✅ Log berhasil dikirim ke webhook."
} catch {
    Write-Output "❌ Gagal kirim log: $_"
}
