# 查本機 IP 複製到剪貼簿

# 方法變數
$NetName = "乙太網路"

# 公共變數
$PauseEnd = 0
$RunCatch = 0
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
	
	# 主功能
	$Value = (Get-NetIPAddress -AddressFamily IPv4).Where({$_.InterfaceAlias -eq $NetName}).IPAddress 
	$Value | Set-Clipboard
	Write-Host $Value
	Send-Notification -Title '已複製字串' -Text $Value
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
