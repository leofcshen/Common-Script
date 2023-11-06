# 方法說明
# 複製 "日期_剪貼簿字串" 到剪貼簿

# 公共變數
$PauseEnd = 0
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數

function Run {
	$Value = "$(Get-Date -Format "yyyyMMdd")_$(Get-Clipboard)"
	$Value | Set-Clipboard
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
