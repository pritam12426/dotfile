^u::                                                                 ; Convert text to upper
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN

^l::                                                                 ; Convert text to lower
 StringLower Clipboard, Clipboard
 Send %Clipboard%
RETURN

+^k::                                                                ; Convert text to capitalized
 StringUpper Clipboard, Clipboard, T
 Send %Clipboard%
RETURN

^k::                                                                 ; Convert text to inverted
 Lab_Invert_Char_Out:= ""
 Loop % Strlen(Clipboard) {
    Lab_Invert_Char:= Substr(Clipboard, A_Index, 1)
    if Lab_Invert_Char is upper
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) + 32)
    else if Lab_Invert_Char is lower
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) - 32)
    else
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Lab_Invert_Char
 }
 Send %Lab_Invert_Char_Out%
RETURN