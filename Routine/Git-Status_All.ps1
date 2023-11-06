# 方法說明
# 檢查所有 Repository git status

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數

function Run {
	$RepoList = Get-ChildItem $Config.GitRepoBase | % { $_.FullName}
	
	foreach ($Target in $RepoList) {
		Set-Location $Target
			
		$Status = git status
		$HasNotStaged = $Status -contains "Changes not staged for commit:"
		$HasUntracked = $Status -contains "Untracked files:"
		
		if($HasNotStaged -or $HasUntracked) {
			Write-Host $Target -ForegroundColor "Green"
			git status
			Write-Host
		}
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
