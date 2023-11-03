﻿# 拉取所有 Repository git pull

# 方法變數

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
	$RepoList = Get-ChildItem $Config.GitRepoBase | % { $_.FullName}
	
	foreach ($Target in $RepoList) {
		Write-Host $Target -ForegroundColor Green
		Set-Location $Target
			
		git pull
	}
	
	Write-Host "程式庫數量：$($RepoList.Count)" -ForegroundColor "Green"
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
