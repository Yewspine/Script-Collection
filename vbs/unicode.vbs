Dim i,x,a 
i = InputBox("type a char to get it corresponding unicode value") 
If i <> "" Then 
For x = 1 To Len(i) 
If x <> Len(i) Then 
a = a & "ChrW(" & AscW(Mid(i,x,1)) & ")" & "&" 
Else 
a = a & "ChrW(" & AscW(Mid(i,x,1)) & ")" 
End if 
Next 
Inputbox "the corresponding unicode for " & qq(i) & " is: ",,a 
End If 
Function qq(strIn)
    qq = Chr(34) & strIn & Chr(34)
End Function
