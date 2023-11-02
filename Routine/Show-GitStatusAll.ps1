# 檢查所有 Repository git status

# 方法變數

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
	
	#主功能	
	$RepoList = Get-ChildItem $Config.GitRepoBase
	
	foreach ($Target in $RepoList) {
		Set-Location $Target
		Write-Host $Target -ForegroundColor Green
		git status
		Write-Host
	}
	
	Write-Host "程式庫數量：$($RepoList.Count)" -ForegroundColor Green	
} Catch {
	if($RunCatch) {
		Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor Red
		Write-Host $_.Exception.Message -ForegroundColor Red
		Write-Host $_.ScriptStackTrace
		Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor Red
		
		Pause
	}	
}

Write-Host "執行完畢" -ForegroundColor Green

Write-Host
if($PauseEnd) {	Pause }
