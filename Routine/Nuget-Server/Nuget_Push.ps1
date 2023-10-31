# Nuget-Server 發行套件

$Version = "2.0.0"

$ConfigPath = "$PSScriptRoot\..\..\config.json"
$ConfigExist = Test-Path -Path $ConfigPath -PathType Leaf

Try {
	if (!$ConfigExist) { throw "$ConfigPath 設定檔不存在"	}
	$Config = Get-Content -Path $ConfigPath | ConvertFrom-Json
	
	$Path = "$($Config.Baget.PackagePath)\$($Config.Baget.PackageName).${Version}.nupkg"
	dotnet nuget push $Path -k $Config.Baget.Key -s $Config.Baget.Url
} Catch {
	Write-Host $_.Exception.Message -ForegroundColor Red
	Write-Host $_.ScriptStackTrace
}

Pause