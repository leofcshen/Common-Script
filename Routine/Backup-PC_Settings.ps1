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
	# 引用 Library
	. $LibraryPath
	# 取得 Config
	$Config = Get-Json $ConfigPath
	# 主功能
	Run
} Catch {
	Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor "Red"
	Write-Host $_.Exception.Message -ForegroundColor "Red"
	Write-Host $_.ScriptStackTrace
	Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor "Red"
}

Write-Host
Write-Host "執行完畢" -ForegroundColor "Green"
Write-Host
if($PauseEnd) {	Pause }
