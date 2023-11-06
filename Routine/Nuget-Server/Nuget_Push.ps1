# 方法說明
# Nuget-Server 發行套件

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
$Version = "2.0.0"
$Path = "$($Config.Baget.PackagePath)\$($Config.Baget.PackageName).${Version}.nupkg"

function Run {
	dotnet nuget push $Path -k $Config.Baget.Key -s $Config.Baget.Url
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
