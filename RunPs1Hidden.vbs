Set objShell = CreateObject("Wscript.Shell")
scriptPath = Wscript.Arguments.Item(0)
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File """ & scriptPath & """", 0, False