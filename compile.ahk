#Requires AutoHotkey v2.0
#SingleInstance Off
CompilerPath := EnvGet("AHK_COMPILER")
BasePath := EnvGet("AHKH2_X64")
SetWorkingDir(A_ScriptDir)

; Compile Script
RunWait '"' CompilerPath '"'
      . ' /in "' A_ScriptDir '/source/script/Script.ahk"'
      . ' /out "' A_ScriptDir '/compiled/M4GScript.exe"'
      . ' /icon "' A_ScriptDir '/icon.ico"'
      . ' /base "' BasePath '"'
      . ' /compress 0'

; Compile Loader
RunWait '"' CompilerPath '"'
      . ' /in "' A_ScriptDir '/source/loader/Script.ahk"'
      . ' /out "' A_ScriptDir '/compiled/ScriptLoader.exe"'
      . ' /icon "' A_ScriptDir '/icon.ico"'
      . ' /base "' BasePath '"'
      . ' /compress 0'