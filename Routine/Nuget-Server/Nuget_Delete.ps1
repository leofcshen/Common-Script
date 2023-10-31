# Nuget-Server 刪除套件 版本

# 方法變數
$Version = "2.0.0"
$PackageName = "Utility"

# 公共變數
$PauseEnd = 1
$RunCatch = 0

Try {
	# 引用腳本
	if(!$Env:PS_Common) { throw "Env:PS_Common 找不到" }
	if(!(Test-Path -Path $Env:PS_Common -PathType Leaf)) { throw "$Env:PS_Common 路徑不存在" }
	. $Env:PS_Common
	
	# Config 如沒用到可省略
	$Config = GetConfig $Env:PS_ConfigPath
	
	# 主功能
	dotnet nuget delete $PackageName $Version -s $Config.Baget.Url -k $Config.Baget.Key --non-interactive
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
