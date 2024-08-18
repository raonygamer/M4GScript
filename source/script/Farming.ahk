#Requires AutoHotkey v2.0
#Include Script.ahk
FarmingActive := false
SelectedWindow := 0
CanRun() {
    return (SelectedWindow && WinExist("ahk_id" SelectedWindow) && FarmingActive)
}

SetStoreCapsLockMode(false)
StartFarmingRoutine() {
    Global ScriptWindow
    loop {
        if (!CanRun() && FarmingActive) {
            ScriptWindow.DisableFarmingScript()
            continue
        }
        IterationCount := 0
        AttackDelay := Random(ScriptWindow.MinAttackTime.Value, ScriptWindow.MaxAttackTime.Value)
        while (IterationCount < 5) {
            AttackCount := 0
            if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                break
            ControlSend("{TAB}", SelectedWindow)
            Sleep(300)
            if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                break
            while (AttackCount < 2) {
                if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                    break
                ControlSend("{PgDn}", SelectedWindow)
                Sleep(300)
                if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                    break
                AttackCount++
            }
            if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                break
            ControlSend("{f down}{f up}", SelectedWindow)
            Sleep(AttackDelay)
            if (!CanRun() || ScriptWindow.OnlyUltCheck.Value)
                break
            IterationCount++
        }
        if (!CanRun())
            continue
        ControlSend("{r down}{r up}", SelectedWindow)
        Sleep(AttackDelay)
    }
}