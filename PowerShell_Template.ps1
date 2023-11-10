# 方法說明
# 

# 公共變數
$PauseEnd = 0
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數

function Run {
	
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
