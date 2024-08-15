#SingleInstance off
SetWorkingDir(A_Temp)
try {
    Download "https://github.com/raonygamer/M4GScript/releases/latest/download/M4GScript.exe", "M4GScript.exe"
}
if (FileExist("M4GScript.exe"))
    if (A_IsAdmin)
        Run "M4GScript.exe"
    else
        try
            Run "*RunAs M4GScript.exe"
        catch
            MsgBox "Você precisa rodar o Loader como Administrador, ou aceitar o prompt UAC."
ExitApp