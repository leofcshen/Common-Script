﻿# Nuget-Server 刪除套件 版本

# 方法變數
$Version = "2.0.0"
$PackageName = "Utility"

# 公共變數
$PauseEnd = 1
$RunCatch = 0

Try {
	$ConfigPath = $Env:ConfigPath
	$ConfigExist = Test-Path -Path $ConfigPath -PathType Leaf
	# 引用設定檔
	if (!$ConfigExist) { throw "$ConfigPath 設定檔不存在"	}
	$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json
	# 引用腳本
	. $Config.BaseScript
	
	#region -- 主功能 --	
	dotnet nuget delete $PackageName $Version -s $Config.Baget.Url -k $Config.Baget.Key --non-interactive
	#endregion
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
