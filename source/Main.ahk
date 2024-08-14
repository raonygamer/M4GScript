#SingleInstance off
SetStoreCapsLockMode(false)
MainGui := Gui(,"Farm Script by rydev",,)
MainGui.OnEvent("Close", CloseGui)
CloseGui(*) {
    ExitApp 0
}

GameDropdown := MainGui.Add("DropDownList", "vaMir4Choice w300", [])
ToggleButton := MainGui.Add("Button", "Default w300 y+20", "Rodar")
DisableOnlyIfGameWindowActiveCheckBox := MainGui.Add("CheckBox", "x10 vOnlyIfGameWindowActive Checked", "Parar com 'Insert' apenas se o jogo estiver em foco")

SearchDelayMin := 2000
SearchDelayMax := 2200
LoopDelayMin := 4900
LoopDelayMax := 5500

SearchDelayMinEdit := MainGui.Add("Edit", "-Limit7 -Number x10 y+20", SearchDelayMin)
MainGui.Add("Text", "yp", "Delay de busca mínimo")
SearchDelayMaxEdit := MainGui.Add("Edit", "-Limit7 -Number x10", SearchDelayMax)
MainGui.Add("Text", "yp", "Delay de busca máximo")
LoopDelayMinEdit := MainGui.Add("Edit", "-Limit7 -Number x10", LoopDelayMin)
MainGui.Add("Text", "yp", "Delay de loop mínimo")
LoopDelayMaxEdit := MainGui.Add("Edit", "-Limit7 -Number x10", LoopDelayMax)
MainGui.Add("Text", "yp", "Delay de loop máximo")

GameWindows := WinGetList("Mir4")
GameWindowHWNDs := Array()
for hwnd in GameWindows {
    WindowTitle := WinGetTitle(hwnd)
    WindowPID := WinGetPid(hwnd)
    GameWindowHWNDs.Push(hwnd)
    GameDropdown.Add([WindowTitle " : " WindowPID])
}

SelectedWindow := 0
GameDropdown.OnEvent("Change", OnSelectGame)
OnSelectGame(pControl, pInfo) {
    Global SelectedWindow
    SelectedWindow := GameWindowHWNDs[GameDropdown.Value]
}

Active := false
ToggleButton.OnEvent("Click", OnClickStartButton)

Ins::OnHotkeyDisableButton
OnHotkeyDisableButton() {
    global SelectedWindow
    if (SelectedWindow == 0 || !WinExist(SelectedWindow)) {
        MsgBox "Você precisa selecionar uma janela para rodar o script!"
        return
    }

    if (!DisableOnlyIfGameWindowActiveCheckBox.Value) {
        OnClickStartButton()
    }
    else if (WinActive("ahk_id" SelectedWindow)) {
        OnClickStartButton()
    }
}

OnClickStartButton(*) {
    Global Active
    Global SelectedWindow
    if (SelectedWindow == 0 && !Active) {
        MsgBox "Você precisa selecionar uma janela para rodar o script!"
        return
    }
    Active := !Active
    ToggleButton.Text := Active ? "Parar" : "Rodar"
}

MainGui.Show

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
                ControlSend("{f down}{f up}", SelectedWindow)
                Sleep(SearchDelay)
                X++
            }
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