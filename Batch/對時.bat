net start "windows time"
rem ���w NTP ���A���@���P�B�ӷ� (�ݭ��� W32Time �A��)
w32tm /config /manualpeerlist:watch.stdtime.gov.tw /syncfromflags:manual /update
rem �]�w�ɶ����A��
rem w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update

rem ���� W32Time �A��
net stop w32time
net start w32time
rem �ߧY�P�ծɨӷ��P�B�ɶ�
w32tm /resync

:: �]�wLog���|
set folder=D:\Log\���\

:: �]�wLOG�ɦW���
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
  set year=%%a
  set month=%%b
  set day=%%c
)

set fileName=%year%-%month%-%day%

:: �g�J Log
echo %date%_%time% >> "%folder%%fileName%.LOG"

:: �ϥ� forfiles �R���W�L 2 �Ѫ��ɮ�
forfiles /p "%folder%" /s /m *.* /d -2 /c "cmd /c del @file"
