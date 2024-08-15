; Made by rydev
#SingleInstance off
#Include GUI.ahk
#Include Kernel32.ahk
#Include Game.ahk

SetStoreCapsLockMode(false)
DoScriptWork() {
    Global Active
    Global SelectedWindow
    Global SearchDelayMinEdit
    Global SearchDelayMaxEdit
    Global LoopDelayMinEdit
    Global LoopDelayMaxEdit
    try {
        while (Active && SelectedWindow != 0 && WinExist("ahk_id" SelectedWindow)) {
            X := 0
            SearchDelay := Random(SearchDelayMinEdit.Value, SearchDelayMaxEdit.Value)
            LoopDelay := Random(LoopDelayMinEdit.Value, LoopDelayMaxEdit.Value)
            while(X < 5)
            {
                if (!Active || SelectedWindow == 0 || !WinExist("ahk_id" SelectedWindow))
                    break
                Y := 0
                ControlSend("{TAB}", SelectedWindow)
                Sleep(300)
                while(Y < 2)
                {
                    if (!Active || SelectedWindow == 0 || !WinExist("ahk_id" SelectedWindow))
                        break
                    ControlSend("{PgDn}", SelectedWindow)
                    Sleep(300)
                    Y++	
                }
                if (!Active || SelectedWindow == 0 || !WinExist("ahk_id" SelectedWindow))
                    break
                ControlSend("{f down}{f up}", SelectedWindow)
                Sleep(SearchDelay)
                X++
            }
            if (!Active || SelectedWindow == 0 || !WinExist("ahk_id" SelectedWindow))
                break
            ControlSend("{r down}{r up}", SelectedWindow)
            Sleep(LoopDelay)
        }
    }
}

loop {
    if (!Active)
        continue
    if (SelectedWindow == 0 || !WinExist(SelectedWindow)) {
        OnClickStartButton()
        continue
    }
    DoScriptWork()
}