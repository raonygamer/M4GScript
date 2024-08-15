#Requires AutoHotkey v2.0
MainGui := Gui(, "Farm Script v1.0.3", ,)
MainGui.OnEvent("Close", CloseGui)
CloseGui(*) {
    ExitApp 0
}

GameDropdown := MainGui.Add("DropDownList", "vaMir4Choice w300", [])
ToggleButton := MainGui.Add("Button", "Default w300", "Rodar")

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
    GameDropdown.Add([WindowTitle " - " WindowPID])
}

SelectedWindow := 0
GameDropdown.OnEvent("Change", OnSelectGame)
OnSelectGame(pControl, pInfo) {
    Global SelectedWindow
    SelectedWindow := GameWindowHWNDs[GameDropdown.Value]
}

Active := false
ToggleButton.OnEvent("Click", OnClickStartButton)

#HotIf (SelectedWindow != 0 && WinExist(SelectedWindow) && WinActive("ahk_id" SelectedWindow))
Ins::OnHotkeyDisableButton
#HotIf
OnHotkeyDisableButton() {
    global SelectedWindow
    if (SelectedWindow == 0 || !WinExist(SelectedWindow)) {
        MsgBox "Você precisa selecionar uma janela para rodar o script!"
        return
    }

    OnClickStartButton()
}

OnClickStartButton(*) {
    Global Active
    Global SelectedWindow
    if (SelectedWindow == 0 && !Active) {
        MsgBox "Você precisa selecionar uma janela para rodar o script!"
        return
    }
    Active := !Active
    if (!Active)
        ControlSend("{esc down}{esc up}", SelectedWindow)
    ToggleButton.Text := Active ? "Parar" : "Rodar"
}
MainGui.Show