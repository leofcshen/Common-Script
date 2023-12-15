# 方法說明
# ping google 超過 N ms 跳通知

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 自訂變數
$Time = 5
$Url = "www.google.com"

function Run {
	$IsRun = $true
	# 持續 ping www.google.com
	while ($IsRun) {
		if($IsPowerShell7) {
			$pingResult = Test-Connection -ComputerName $Url -Count 1
			$responseTime = $pingResult.Latency
		} else {
			
		}
		
		$date = Get-Date
		$Message = "回應時間: $($responseTime)ms"
		Write-Host $Message
		
		if ($responseTime -gt $Time) {
			$Title = "Ping [$($Url)] 回應超時"
			$Message = "$date`n$Message"
			Send-Notification -Title $Title -Text $Message
		}
		Start-Sleep -Seconds 1
	}
}

Try {
	. $LibraryPath
	$Config = Get-Json $ConfigPath
	$IsPowerShell7 = Check-PowerShellVersion
	Run
} Catch {
	Show-Error
}

Show-End