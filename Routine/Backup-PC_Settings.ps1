# 方法說明
# 備份電腦設定

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
# region -- 要備份的資料夾清單 --
# Outlook 簽名檔資料夾
$OutlookSignatures = $Env:APPDATA + "\Microsoft\Signatures"
# VPN 設定資料夾
$Vpn = $Env:APPDATA + "\Microsoft\Network\Connections\Pbk"
# 啟動資料夾
$Stratup = $Env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup"
#endregion
 
$BackupList = $OutlookSignatures, $Vpn, $Stratup
$BackupBase = "D:\LeoShen\PC_Backup\PowerShell_Backup"
$ScriptPath = "D:\Code\Github_leofcshen\PowerShell_Sample\Script\Backup-Folder.ps1"

# 備份排程目的資料夾
$BackupPath_ScheduledTask = "D:\LeoShen\PC_Backup\PowerShell_Backup\ScheduledTask"

function Run {
	Write-Host "備份資料夾開始"
	foreach ($Target in $BackupList) {
		if(Test-Path -Path $Target -PathType Container) {
			. $ScriptPath $Target $BackupBase
		} else {
			Write-Error "路徑不存在 $Target"
		}
	}
	
	Write-Host "備份排程開始"	
	Get-ScheduledTask |
		# 自訂過濾條件
		Where TaskName -Match "^_" |
		Select -Expand TaskName |
		% { Export-ScheduledTask -TaskName $_ | Out-File ($backupPath + "\$_.xml") }	
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
