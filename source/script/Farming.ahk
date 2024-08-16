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
        if (!CanRun()) {
            ScriptWindow.DisableFarmingScript()
            continue
        }
        while (CanRun()) {
            IterationCount := 0
            AttackDelay := Random(ScriptWindow.MinAttackTime.Value, ScriptWindow.MaxAttackTime.Value)
            while (IterationCount < 5) {
                AttackCount := 0
                if (!CanRun())
                    break
                ControlSend("{TAB}", SelectedWindow)
                Sleep(300)
                if (!CanRun())
                    break
                while (AttackCount < 2) {
                    if (!CanRun())
                        break
                    ControlSend("{PgDn}", SelectedWindow)
                    Sleep(300)
                    if (!CanRun())
                        break
                    AttackCount++
                }
                if (!CanRun())
                    break
                ControlSend("{f down}{f up}", SelectedWindow)
                Sleep(AttackDelay)
                if (!CanRun())
                    break
                IterationCount++
            }
            if (!CanRun())
                break
            ControlSend("{r down}{r up}", SelectedWindow)
            Sleep(AttackDelay)
        }
    }
}