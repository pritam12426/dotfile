; :o::: = will remover the last space for the Line
; :*::: = will start the line without putting space after the scrip
; :r::: = will rasturese the spical keybord button

#NoEnv ; (This is for security)
#SingleInstance force ; (This is for removing the confraction box for reloding the scrip)

; Functon for opepn a file
    Openfile(FileName){
        if FileExist(FileName)
            IfWinNotActive, %FileName%
                Run, %FileName%
        Else
            IfWinExist, %FileName%
                WinActivate, %FileName%
        }

; For Reloading the file:
    ^!F5::
    {
    IfWinActive, ahk_class Chrome_WidgetWin_1 
        Reload
    Else
        MsgBox, "Visual Studio Code window in not active"
        Return
    }
; For date:
    ^F2::
    FormatTime, Date,, yyyy-MMM-dd_
    SendInput, %Date% ;(This is a virible of FormaTime)
    Return
	
; Open Code_playground file:
    ^F1::
    Openfile("C:\Users\Pritam\Desktop\Cording_playground")
    Return
; Open Screen_short
    ^F3::
    Openfile("D:\ScreenShort\Shere_X_Screen_Short")
    Return

; scrip
    :r*:temp..::temporary
    Return

    :or*:@@..::pritamkumar12426@gmail.com
    Return
    
    :or*:pw..::password@8472034090 
    Return

    :r*:dow..::download
    Return

    :*r:vs..::Visual Studio Code
    Return