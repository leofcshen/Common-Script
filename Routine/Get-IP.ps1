# 方法說明
# 查本機 IP 複製到剪貼簿

# 公共變數
$PauseEnd = 0
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
$NetName = "乙太網路"

function Run {
	$Value = (Get-NetIPAddress -AddressFamily IPv4).Where({$_.InterfaceAlias -eq $NetName}).IPAddress 
	$Value | Set-Clipboard
	Write-Host $Value
	Send-Notification -Title '已複製字串' -Text $Value
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
