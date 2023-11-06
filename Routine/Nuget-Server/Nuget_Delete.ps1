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
	# 引用 Library
	. $LibraryPath
	# 取得 Config
	$Config = Get-Json $ConfigPath
	# 主功能
	Run
} Catch {
	Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor "Red"
	Write-Host $_.Exception.Message -ForegroundColor "Red"
	Write-Host $_.ScriptStackTrace
	Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor "Red"
}

Write-Host
Write-Host "執行完畢" -ForegroundColor "Green"
Write-Host
if($PauseEnd) {	Pause }
