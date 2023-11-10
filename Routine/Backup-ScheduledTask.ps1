# 方法說明
# 備份排程

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 方法變數
$backupPath = "D:\LeoShen\PC_Backup\PowerShell_Backup\ScheduledTask"

function Run {
	Get-ScheduledTask |
		Where TaskName -Match "^_" |
		Select -Expand TaskName |
		% { Export-ScheduledTask -TaskName $_ | Out-File ($backupPath + "\$_.xml") }
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	Run
} Catch {
	Show-Error
}

Show-End
