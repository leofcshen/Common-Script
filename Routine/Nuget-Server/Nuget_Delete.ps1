# Nuget-Server 刪除套件 版本

$Version = "2.0.0"
$PackageName = "Utility"

$ConfigPath = "$PSScriptRoot\..\..\config.json"
$ConfigExist = Test-Path -Path $ConfigPath -PathType Leaf

Try {
	if (!$ConfigExist) { throw "$ConfigPath 設定檔不存在"	}
	$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json
	
	dotnet nuget delete $PackageName $Version -s $Config.Baget.Url -k $Config.Baget.Key
} Catch {
	Write-Host $_.Exception.Message -ForegroundColor Red
	Write-Host $_.ScriptStackTrace
}

Pause