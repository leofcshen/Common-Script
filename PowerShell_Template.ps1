# 方法說明

# 方法變數

# 公共變數
$PauseEnd = 0
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
