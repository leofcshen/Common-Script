# 方法說明
# Nuget-Server 刪除套件 版本

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
$Version = "2.0.0"
$PackageName = "Utility"

function Run {
	dotnet nuget delete $PackageName $Version -s $Config.Baget.Url -k $Config.Baget.Key --non-interactive
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
