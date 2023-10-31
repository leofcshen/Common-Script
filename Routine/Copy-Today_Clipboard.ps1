# 複製 "日期_剪貼簿字串" 到剪貼簿
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
	$Value = "$(Get-Date -Format "yyyyMMdd")_$(Get-Clipboard)"
	$Value | Set-Clipboard

	Send-Notification -Title '已複製字串' -Text $Value
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
