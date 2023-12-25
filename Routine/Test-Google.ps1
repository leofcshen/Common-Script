# 方法說明
# ping google 超過 N ms 跳通知

# 公共變數
$PauseEnd = 1
$LibraryPath = $Env:PS_Library
$ConfigPath = $Env:PS_Config

# 自訂變數
## 回應時間閾值(ms)
$ResponseTimeLimit = 4
## 目標 Domain
$Url = "www.google.com"
## 測試時間間隔(s)
$Intervals = 5

function Run {
	# 持續 Test 目標
	while ($true) {
		$Date = Get-Date
		$Action = "Test 目標"
		
		if ($IsPowerShell7) {
			# 是 PowerShell 7
			# $IsSuccess = Test-Connection -ComputerName $Url -Quiet -Count 1
			
			try { 
				$PingResult = Test-Connection -ComputerName $Url -ErrorAction Stop -Count 1
				$ResponseTime = $PingResult.Latency
			} catch {
				# 測試失敗 continue
				$Result = "失敗"
				$Title = $Action + " " + $Result
				Write-Color -Text "$Date => ", $Action, " $Url", $Result -Color White, White, White, Red
				$Message = "測試時間：$Date`n"
				$Message += "測試目標：$Url`n"
				Send-Notification -Title $Title -Text $Date -IconType Error
				Start-Sleep -Seconds $Intervals
				continue
			}
		} else {
			# 不是 PowerShell 7
		}
		
		$Result = "成功"
		$Title = $Action + " " + $Result
		# 回應時間顏色
		$ResponseTimeColor = $ResponseTime -gt $ResponseTimeLimit ? "Red" : "Green"
		# 格式化回應時間左邊補到 3 位
		$ResponseTimeFormat = "{0,3}" -f $ResponseTime
		Write-Color -Text "$Date => $Action ", $Url, " $Result", " => 回應時間: ", $ResponseTimeFormat, " ms" -Color , Yellow, Green, , $ResponseTimeColor,
		
		if ($ResponseTime -gt $ResponseTimeLimit) {
			$Title = "Test 回應時間超過設定閾值：$ResponseTimeLimit ms"
			$Message = "測試時間：$Date`n"
			$Message += "測試目標：$Url`n"
			$Message += "回應時間：$($ResponseTime) ms"
			Send-Notification -Title $Title -Text $Message
		}
		
		Start-Sleep -Seconds $Intervals
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
