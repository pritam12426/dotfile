#NoEnv ; (This is for security)
#SingleInstance force ; (This is for removing the confraction box for reloding the scrip)
; ******************************************

#If MouseIsOver( "ahk_class Shell_TrayWnd") ; (If your mouse is in the task bar in windows)
    Wheelup:: Send {Volume_Up 5}
    WheelDown:: Send {Volume_Down 5}
    MButton::  Send, ToggleEnable {Volume_Mute}
        MouseIsOver(winTitel) 
        {
        MouseGetPos,,, Win
            return WinExist(winTitel " ahk_id " Win)
    }
Return