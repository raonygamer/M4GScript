#Requires AutoHotkey v2.0
#SingleInstance Off
#Include Gui.ahk
#Include Farming.ahk
ScriptVersion := "v1.0.5"
ScriptWindow := ScriptGui()

#HotIf (SelectedWindow && WinExist("ahk_id" SelectedWindow) && WinActive("ahk_id" SelectedWindow))
Ins:: {
    ScriptWindow.ToggleFarmingScript()
}
#HotIf

ScriptWindow.Show()
StartFarmingRoutine()