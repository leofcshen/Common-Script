:: 1.�P�B�ɶ�
:: 2.�R���L�� Log
:: 3.�g log

:: �]�w Log ���|
set folder=D:\Log\���
:: �]�w log �L���Ѽ�
set days=-2

net start "windows time"
rem ���w NTP ���A���@���P�B�ӷ� (�ݭ��� W32Time �A��)
w32tm /config /manualpeerlist:watch.stdtime.gov.tw /syncfromflags:manual /update
rem �]�w�ɶ����A��
rem w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update

rem ���� W32Time �A��
net stop w32time
net start w32time
rem �ߧY�P�ծɨӷ��P�B�ɶ�
w32tm /resync/

:: �ϥ� forfiles �R���W�L days �Ѫ��ɮ�
forfiles /p "%folder%" /s /m *.* /d %days% /c "cmd /c del @file"
::forfiles /p "%folder%" /s /m *.* /d -2 /c "cmd /c del @file":: 2>nul

:: �]�w LOG �ɦW���
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
  set year=%%a
  set month=%%b
  set day=%%c
)

set fileName=%year%-%month%-%day%

:: �g�J Log
echo %date%_%time% >> "%folder%\%fileName%.log"

::forfiles /p "D:\LOG\WEB\A" /s /m *.log /d -60 /c  "cmd /c echo  del @path /q  ... && del @path /q " 
