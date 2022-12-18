'------ Admin rights!
' source: https://stackoverflow.com/a/17467283
If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If


'------ Update the registry.
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegDelete "HKEY_CLASSES_ROOT\*\shell\Open with YAFFplayer\command\"
WshShell.RegDelete "HKEY_CLASSES_ROOT\*\shell\Open with YAFFplayer\"

Wscript.Echo "YAFFplayer removed from Explorer context menu."


