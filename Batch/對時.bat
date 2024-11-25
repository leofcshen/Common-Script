:: 1.同步時間
:: 2.刪除過期 Log
:: 3.寫 log

:: 設定 Log 路徑
set folder=D:\Log\對時
:: 設定 log 過期天數
set days=-2

net start "windows time"
rem 指定 NTP 伺服器作為同步來源 (需重啟 W32Time 服務)
w32tm /config /manualpeerlist:watch.stdtime.gov.tw /syncfromflags:manual /update
rem 設定時間伺服器
rem w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update

rem 重啟 W32Time 服務
net stop w32time
net start w32time
rem 立即與校時來源同步時間
w32tm /resync/

:: 使用 forfiles 刪除超過 days 天的檔案
forfiles /p "%folder%" /s /m *.* /d %days% /c "cmd /c del @file"
::forfiles /p "%folder%" /s /m *.* /d -2 /c "cmd /c del @file":: 2>nul

:: 設定 LOG 檔名日期
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
  set year=%%a
  set month=%%b
  set day=%%c
)

set fileName=%year%-%month%-%day%

:: 寫入 Log
echo %date%_%time% >> "%folder%\%fileName%.log"

::forfiles /p "D:\LOG\WEB\A" /s /m *.log /d -60 /c  "cmd /c echo  del @path /q  ... && del @path /q " 
