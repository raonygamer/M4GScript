#Requires AutoHotkey v2.0
class Mir4 {
    static IsSteamVersion(ProcessID) {
        return ProcessGetName(ProcessID) == "Mir4S.exe"
    }
}