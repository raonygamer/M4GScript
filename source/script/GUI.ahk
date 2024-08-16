#Requires AutoHotkey v2.0
#Include Script.ahk
#Include Farming.ahk

DefaultMinAttackTime := 2000
DefaultMaxAttackTime := 2200

class ScriptGui {
    MainGui := Gui("", Format("Mir Script {}", ScriptVersion))
    GameSelector := this.MainGui.AddListView("vGameSelector w300 Checked", ["Título                ", "ID do Processo"])
    GameWindowList := []
    RunButton := this.MainGui.AddButton("Disabled w300", "Rodar")
    MinAttackTimeText := this.MainGui.AddText("Section x10 Center", "Delay de ataque mínimo  ")
    MinAttackTime := this.MainGui.AddSlider("Range200-3200 ys ToolTipBottom", DefaultMinAttackTime)
    MaxAttackTimeText := this.MainGui.AddText("Section x10 Center", "Delay de ataque máximo  ")
    MaxAttackTime := this.MainGui.AddSlider("Range300-3300 ys ToolTipBottom", DefaultMaxAttackTime)

    __New() {
        this.MainGui.OnEvent("Close", this.Close.Bind(this))
        this.GameSelector.OnEvent("ItemCheck", this.OnSelectGame.Bind(this))
        this.RunButton.OnEvent("Click", this.ToggleFarmingScript.Bind(this))
        this.UpdateGameSelector()
    }

    UpdateGameSelector() {
        this.GameSelector.Delete()
        this.GameWindowList := []
        for WindowHandle in WinGetList("Mir4") {
            this.GameWindowList.Push(WindowHandle)
            this.GameSelector.Add(, WinGetTitle(WindowHandle), WinGetPID(WindowHandle))
        }
        this.RunButton.Opt("+Disabled")
    }

    OnSelectGame(obj, item, checked) {
        global SelectedWindow
        loop this.GameSelector.GetCount("Col") {
            if (A_Index == item)
                continue
            this.GameSelector.Modify(A_Index, "-Check")
        }

        if (!checked && FarmingActive && SelectedWindow && WinExist(SelectedWindow)) {
            ControlSend("{Esc down}{Esc up}", SelectedWindow)
        }

        if (!checked)
            SelectedWindow := 0
        else
            SelectedWindow := this.GameWindowList[item]
        if (SelectedWindow && WinExist(SelectedWindow))
            this.RunButton.Opt("-Disabled")
        else
            this.RunButton.Opt("+Disabled")
    }

    DisableFarmingScript(*) {
        global FarmingActive
        FarmingActive := false
        this.RunButton.Text := FarmingActive ? "Parar" : "Rodar"
        if (!FarmingActive && SelectedWindow && WinExist(SelectedWindow)) {
            ControlSend("{Esc down}{Esc up}", SelectedWindow)
        }
    }

    EnableFarmingScript(*) {
        global FarmingActive
        FarmingActive := true
        this.RunButton.Text := FarmingActive ? "Parar" : "Rodar"
    }

    ToggleFarmingScript(*) {
        global FarmingActive
        if (FarmingActive)
            this.DisableFarmingScript()
        else
            this.EnableFarmingScript()
    }

    Show() {
        this.MainGui.Show()
    }

    Hide() {
        this.MainGui.Hide()
    }

    Close(*) {
        ExitApp(0)
    }
}