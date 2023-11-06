# Nuget-Server 發行套件

# 方法變數
$Version = "2.0.0"

# 公共變數
$PauseEnd = 1
$RunCatch = 0
$LibraryPath = ""
$ConfigPath = ""
$GetLibraryPathFunction = "D:\Code\Github_leofcshen\PowerShell_Sample\Function\Common\Get-LibraryPath.ps1"
$GetConfigPathFunction = "D:\Code\Github_leofcshen\PowerShell_Sample\Function\Common\Get-Config.ps1"

function Run {
	$Path = "$($Config.Baget.PackagePath)\$($Config.Baget.PackageName).${Version}.nupkg"
	dotnet nuget push $Path -k $Config.Baget.Key -s $Config.Baget.Url
}

Try {
	# 引用 Library
	. $GetLibraryPathFunction
	. (Get-LibraryPath $LibraryPath)
	# 取得 Config
	. $GetConfigPathFunction
	$Config = Get-Config $ConfigPath
	# 主功能
	Run
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
