# 方法說明
# 備份電腦設定

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
# region -- 資料夾清單 --
# Outlook 簽名檔
$OutlookSignatures = $Env:APPDATA + "\Microsoft\Signatures"
# VPN 設定
$Vpn = $Env:APPDATA + "\Microsoft\Network\Connections\Pbk"
# 啟動資料夾
$Stratup = $Env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup"
#endregion
$BackupTarget = $OutlookSignatures, $Vpn, $Stratup
$BackupBase = "D:\LeoShen\PC_Backup\PowerShell_Backup"
$ScriptPath = "D:\Code\Github_leofcshen\PowerShell_Sample\Script\Backup-Folder.ps1"

function Run {
	foreach ($Target in $BackupTarget) {
		if(Test-Path -Path $Target -PathType Container) {
			. $ScriptPath $Target $BackupBase
		} else {
			Write-Error "路徑不存在 $Target"
		}
	}
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
