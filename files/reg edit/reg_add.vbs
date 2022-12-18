'------ Admin rights!
' source: https://stackoverflow.com/a/17467283
If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If




' Dim fso: set fso = CreateObject("Scripting.FileSystemObject")
' Dim current_dir
' current_dir = fso.GetAbsolutePathName(".")

dim scriptdir
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)



dim app_full_path 
app_full_path = scriptdir & "\YAFFplayer.exe"

dim command_value
' Chr(34) for double quote (")
command_value = app_full_path & " " & Chr(34) & "%1" & Chr(34)

dim icon_full_path 
icon_full_path = scriptdir & "\icon.ico"


'------ Update the registry.
Set WshShell = CreateObject("WScript.Shell")
WshShell.RegWrite "HKEY_CLASSES_ROOT\*\shell\Open with YAFFplayer\command\", command_value, "REG_SZ"
WshShell.RegWrite "HKEY_CLASSES_ROOT\*\shell\Open with YAFFplayer\", "Open video with YAFFplayer", "REG_SZ"
WshShell.RegWrite "HKEY_CLASSES_ROOT\*\shell\Open with YAFFplayer\Icon", icon_full_path, "REG_SZ"

dim crlf
crlf = Chr(13) & Chr(10)

Wscript.Echo "YAFFplayer full path:" & vbCrLf & app_full_path & vbCrLf & vbCrLf & "YAFFplayer added to Explorer context menu."


