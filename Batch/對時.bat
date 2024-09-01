net start "windows time"
rem 指定 NTP 伺服器作為同步來源 (需重啟 W32Time 服務)
w32tm /config /manualpeerlist:watch.stdtime.gov.tw /syncfromflags:manual /update
rem 設定時間伺服器
rem w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update

rem 重啟 W32Time 服務
net stop w32time
net start w32time
rem 立即與校時來源同步時間
w32tm /resync

:: 設定Log路徑
set folder=D:\Log\對時\

:: 設定LOG檔名日期
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
  set year=%%a
  set month=%%b
  set day=%%c
)

set fileName=%year%-%month%-%day%

:: 寫入 Log
echo %date%_%time% >> "%folder%%fileName%.LOG"

:: 使用 forfiles 刪除超過 2 天的檔案
forfiles /p "%folder%" /s /m *.* /d -2 /c "cmd /c del @file"
