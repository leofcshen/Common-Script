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
