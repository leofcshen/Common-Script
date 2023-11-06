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
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
