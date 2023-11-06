# 方法說明
# 拉取所有 Repository git pull

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數

function Run {
	$RepoList = Get-ChildItem $Config.GitRepoBase | % { $_.FullName}
	
	foreach ($Target in $RepoList) {
		Write-Host $Target -ForegroundColor Green
		Set-Location $Target
			
		git pull
	}
	
	Write-Host "程式庫數量：$($RepoList.Count)" -ForegroundColor "Green"
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
