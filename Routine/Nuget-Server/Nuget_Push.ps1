# Nuget-Server 發行套件
$ConfigPath = $Env:ConfigPath
$ConfigExist = Test-Path -Path $ConfigPath -PathType Leaf

Try {
	# 引用設定檔
	if (!$ConfigExist) { throw "$ConfigPath 設定檔不存在"	}
	$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json
	# 引用腳本
	. $Config.BaseScript
	
	#region -- 主功能 --
	$Version = "2.0.0"
	
	$Path = "$($Config.Baget.PackagePath)\$($Config.Baget.PackageName).${Version}.nupkg"
	dotnet nuget push $Path -k $Config.Baget.Key -s $Config.Baget.Url
	#endregion
} Catch {
	Write-Host $_.Exception.Message -ForegroundColor Red
	Write-Host $_.ScriptStackTrace
}

Pause