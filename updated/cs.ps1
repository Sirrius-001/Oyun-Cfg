﻿Clear-Host
$host.ui.RawUI.WindowTitle = "CS"
# Cs oyunu için işlemler yapılıyor...
Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1iNfubaww_df_A9IlIS-bavKWVqfHt3dw" -OutFile "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg"

Write-Host "Islem tamamlandi. Ana menuye donuluyor..." -ForegroundColor Green
Start-Sleep -Seconds 2
PowerShell.exe -ExecutionPolicy Bypass -Command "& { Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/SirriusV1/Oyun-Cfg/main/updated/main.ps1' | Invoke-Expression }"