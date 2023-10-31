# 複製 "日期_剪貼簿字串" 到剪貼簿

# 公共變數
$PauseEnd = 0
$RunCatch = 0

Try {
	# 引用腳本
	if(!$Env:PS_Common) { throw "Env:PS_Common 找不到" }
	if(!(Test-Path -Path $Env:PS_Common -PathType Leaf)) { throw "$Env:PS_Common 路徑不存在" }
	. $Env:PS_Common
	
	# 主功能 
	$Value = "$(Get-Date -Format "yyyyMMdd")_$(Get-Clipboard)"
	$Value | Set-Clipboard
	Send-Notification -Title '已複製字串' -Text $Value
} Catch {
	if($RunCatch) {
		Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor Red
		Write-Host $_.Exception.Message -ForegroundColor Red
		Write-Host $_.ScriptStackTrace
		Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor Red
		
		Pause
	}	
}

if($PauseEnd) {	Pause }
