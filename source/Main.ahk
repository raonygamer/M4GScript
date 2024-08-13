#MaxThreadsPerHotkey 2
#SingleInstance off
MainGui := Gui(, "M4G Script by raonyreis13",,)
Mir4ProcessDropdown := MainGui.Add("DropDownList", "vMir4Choice w300", [])
ToggleButton := MainGui.Add("Button", "Default w300", "Rodar")

SearchDelayMin := 2000
SearchDelayMax := 2200
LoopDelayMin := 4900
LoopDelayMax := 5500

SearchDelayMinEdit := MainGui.Add("Edit", "-Limit7 -Number x10", SearchDelayMin)
MainGui.Add("Text", "yp", "Delay de busca mínimo")

SearchDelayMaxEdit := MainGui.Add("Edit", "-Limit7 -Number x10", SearchDelayMax)
MainGui.Add("Text", "yp", "Delay de busca máximo")

LoopDelayMinEdit := MainGui.Add("Edit", "-Limit7 -Number x10", LoopDelayMin)
MainGui.Add("Text", "yp", "Delay de loop mínimo")

LoopDelayMaxEdit := MainGui.Add("Edit", "-Limit7 -Number x10", LoopDelayMax)
MainGui.Add("Text", "yp", "Delay de loop máximo")

MainGui.OnEvent("Close", CloseGui)
CloseGui(*) {
    ExitApp 0
}

WindowIDList := WinGetList("Mir4", , , )
Mir4WindowIDS := Array()
for windowId in WindowIDList {
    WindowTitle := WinGetTitle(windowId)
    WindowPID := WinGetPid(windowId)
    Mir4WindowIDS.Push(windowId)
    Mir4ProcessDropdown.Add([WindowTitle " : " WindowPID])
}

SelectedWindow := 0
OnSelectMir4(pControl, pInfo) {
    Global SelectedWindow
    SelectedWindow := Mir4WindowIDS[Mir4ProcessDropdown.Value]
}
Mir4ProcessDropdown.OnEvent("Change", OnSelectMir4)

Active := false
OnClickStartButton(*) {
    Global Active
    Global SelectedWindow
    if (SelectedWindow == 0 && !Active) {
        MsgBox "Você precisa selecionar um id de processo para rodar o script!"
        return
    }
    Active := !Active
    ToggleButton.Text := Active ? "Parar" : "Rodar"
}
ToggleButton.OnEvent("Click", OnClickStartButton)
MainGui.Show
loop {
    Global Active
    Global SelectedWindow
    Global SearchDelayMinEdit
    Global SearchDelayMaxEdit
    Global LoopDelayMinEdit
    Global LoopDelayMaxEdit
    if (!Active || SelectedWindow == 0)
        continue
    
    X := 0
    SearchDelay := SearchDelayMinEdit.Value
    LoopDelay := LoopDelayMinEdit.Value
    SearchDelay := Random(SearchDelayMinEdit.Value, SearchDelayMaxEdit.Value)
    LoopDelay := Random(LoopDelayMinEdit.Value, LoopDelayMaxEdit.Value)
    SetStoreCapslockMode(Off)
    while(X < 5)
    {
        if (!Active || SelectedWindow == 0)
            continue
        Y := 0
        ControlSend("{TAB}", SelectedWindow)
        Sleep(300)
        while(Y < 2)
        {
            if (!Active || SelectedWindow == 0)
                continue
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

Ins:: {
    OnClickStartButton()
}