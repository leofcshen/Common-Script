# 備份電腦設定

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

# 公共變數
$PauseEnd = 1
$RunCatch = 1
$LibraryPath = ""
$ConfigPath = ""
$GetLibraryPathFunction = "D:\Code\Github_leofcshen\PowerShell_Sample\Function\Common\Get-LibraryPath.ps1"
$GetConfigPathFunction = "D:\Code\Github_leofcshen\PowerShell_Sample\Function\Common\Get-Config.ps1"


Try {
	# 引用 Library
	. $GetLibraryPathFunction
	. (Get-LibraryPath $LibraryPath)
	# 取得 Config
	. $GetConfigPathFunction
	$Config = Get-Config $ConfigPath
	
	#主功能
	foreach ($Target in $BackupTarget) {
		if(Test-Path -Path $Target -PathType Container) {
			. $ScriptPath $Target $BackupBase
		} else {
			Write-Error "路徑不存在 $Target"
		}
	}
} Catch {
	if($RunCatch) {
		Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor "Red"
		Write-Host $_.Exception.Message -ForegroundColor "Red"
		Write-Host $_.ScriptStackTrace
		Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor "Red"
		
		Pause
	}	
}

Write-Host
Write-Host "執行完畢" -ForegroundColor "Green"
Write-Host
if($PauseEnd) {	Pause }
