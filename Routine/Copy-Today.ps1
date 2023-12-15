# 方法說明
# 複製日期到剪貼簿

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數

function Run {
	$Value = $(Get-Date -Format "yyyyMMdd")
	$Value | Set-Clipboard
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
