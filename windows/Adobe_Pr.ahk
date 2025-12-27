#NoEnv
#SingleInstance force

;Create New Folder
    ^Numpad0::
    IfWinActive ahk_class CabinetWClass
    CreateFolder("Documents")
    CreateFolder("Assets")
    CreateFolder("Edit Data")
    CreateFolder("Sound")


    CreateFolder(FolderName) {
        Send, ^+n
        Sleep, 550
        Send, %FolderName%
        Send, {Enter}
        }    Return
        
;Set all folder hotkey to "off" (Initial state of program)
    AllOff:
    Hotkey, ^Numpad2, off
    Hotkey, ^Numpad3, off
    Hotkey, ^Numpad4, off
    Hotkey, ^Numpad5, off
    Return
    ; InputBox prompts for active folder location / Error handling 
    ^Numpad1::

    InputBox, Foldername, Set Activate project Folder, Enter project Folder Path:,, 300, 130,,,,, %Foldername%
    ;InputBox prompts to set active folder location
    If (ErrorLevel = 1) {       ;Checks if user hit Cancel/ESC
    }
Else If FileExist(Foldername)     {        ;Checks if file path is valid; if TRUE, hotkeys ON
MsgBox,, Active Folder Set, Active Folder: %Foldername%., 1
    Hotkey, ^Numpad2, on
    Hotkey, ^Numpad3, on
    Hotkey, ^Numpad4, on
    Hotkey, ^Numpad5, on
}
Else If FileExist(Foldername = "") {       ;Checks if user entered nothing
    MsgBox,, Hotkey OFF, Invaid file path., 2
    Gosub, Alloff
    return
}

;Hotkeys that access each folder individually 

^Numpad3::
if FileExist(Foldername "/Documents")
    Run, %Foldername%/Documents
    Return

^Numpad2::
if FileExist(Foldername "/Assets")
    Run, %Foldername%/Assets
    Return

^Numpad4::
if FileExist(Foldername "/Edit Data")
    Run, %Foldername%/Edit Data
    Return

^Numpad5::
if FileExist(Foldername "/Sound")
    Run, %Foldername%/Sound
    Return   