#Requires AutoHotkey v2.0

class PROCESS_ACCESS_RIGHTS {
    static PROCESS_TERMINATE := 0x00000001
    static PROCESS_CREATE_THREAD := 0x00000002
    static PROCESS_SET_SESSIONID := 0x00000004
    static PROCESS_VM_OPERATION := 0x00000008
    static PROCESS_VM_READ := 0x00000010
    static PROCESS_VM_WRITE := 0x00000020
    static PROCESS_DUP_HANDLE := 0x00000040
    static PROCESS_CREATE_PROCESS := 0x00000080
    static PROCESS_SET_QUOTA := 0x00000100
    static PROCESS_SET_INFORMATION := 0x00000200
    static PROCESS_QUERY_INFORMATION := 0x00000400
    static PROCESS_SUSPEND_RESUME := 0x00000800
    static PROCESS_QUERY_LIMITED_INFORMATION := 0x00001000
    static PROCESS_SET_LIMITED_INFORMATION := 0x00002000
    static PROCESS_ALL_ACCESS := 0x001FFFFF
    static PROCESS_DELETE := 0x00010000
    static PROCESS_READ_CONTROL := 0x00020000
    static PROCESS_WRITE_DAC := 0x00040000
    static PROCESS_WRITE_OWNER := 0x00080000
    static PROCESS_SYNCHRONIZE := 0x00100000
    static PROCESS_STANDARD_RIGHTS_REQUIRED := 0x000F0000
}

class PAGE_PROTECTION_FLAGS {
    static PAGE_NOACCESS := 0x00000001
    static PAGE_READONLY := 0x00000002
    static PAGE_READWRITE := 0x00000004
    static PAGE_WRITECOPY := 0x00000008
    static PAGE_EXECUTE := 0x00000010
    static PAGE_EXECUTE_READ := 0x00000020
    static PAGE_EXECUTE_READWRITE := 0x00000040
    static PAGE_EXECUTE_WRITECOPY := 0x00000080
    static PAGE_GUARD := 0x00000100
    static PAGE_NOCACHE := 0x00000200
    static PAGE_WRITECOMBINE := 0x00000400
    static PAGE_GRAPHICS_NOACCESS := 0x00000800
    static PAGE_GRAPHICS_READONLY := 0x00001000
    static PAGE_GRAPHICS_READWRITE := 0x00002000
    static PAGE_GRAPHICS_EXECUTE := 0x00004000
    static PAGE_GRAPHICS_EXECUTE_READ := 0x00008000
    static PAGE_GRAPHICS_EXECUTE_READWRITE := 0x00010000
    static PAGE_GRAPHICS_COHERENT := 0x00020000
    static PAGE_GRAPHICS_NOCACHE := 0x00040000
    static PAGE_ENCLAVE_THREAD_CONTROL := 0x80000000
    static PAGE_REVERT_TO_FILE_MAP := 0x80000000
    static PAGE_TARGETS_NO_UPDATE := 0x40000000
    static PAGE_TARGETS_INVALID := 0x40000000
    static PAGE_ENCLAVE_UNVALIDATED := 0x20000000
    static PAGE_ENCLAVE_MASK := 0x10000000
    static PAGE_ENCLAVE_DECOMMIT := 0x10000000
    static PAGE_ENCLAVE_SS_FIRST := 0x10000001
    static PAGE_ENCLAVE_SS_REST := 0x10000002
    static SEC_PARTITION_OWNER_HANDLE := 0x00040000
    static SEC_64K_PAGES := 0x00080000
    static SEC_FILE := 0x00800000
    static SEC_IMAGE := 0x01000000
    static SEC_PROTECTED_IMAGE := 0x02000000
    static SEC_RESERVE := 0x04000000
    static SEC_COMMIT := 0x08000000
    static SEC_NOCACHE := 0x10000000
    static SEC_WRITECOMBINE := 0x40000000
    static SEC_LARGE_PAGES := 0x80000000
    static SEC_IMAGE_NO_EXECUTE := 0x11000000
}

class Kernel32 {
    static OpenProcess(DesiredAccess, InheritHandle, ProcessId) {
        Handle := DllCall("OpenProcess", "Ptr", DesiredAccess, "Ptr", InheritHandle, "Ptr", ProcessId)
        if (!Handle)
            throw OSError(, -1)
        return Handle
    }

    static ReadProcessMemory(ProcessHandle, Address, Size) {
        BufferObject := Buffer(Size, 0)
        Result := DllCall("ReadProcessMemory", "Ptr", ProcessHandle, "Ptr", Address, "Ptr", BufferObject, "Ptr", Size, "Ptr", 0)
        if (!Result)
            throw OSError(, -1)
        return BufferObject
    }

    static VirtualProtectEx(ProcessHandle, Address, Size, Protection) {
        OldProtection := Buffer(4, 0)
        Result := DllCall("VirtualProtectEx", "Ptr", ProcessHandle, "Ptr", Address, "Ptr", Size, "Ptr", Protection, "Ptr", OldProtection)
        if (!Result)
            throw OSError(, -1)
        return NumGet(OldProtection, 0, "uint")
    }
}