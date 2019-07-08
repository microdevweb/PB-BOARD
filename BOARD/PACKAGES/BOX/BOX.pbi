; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : 
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
DeclareModule BOX
  Interface MethodBox
    addMeToBoard(board)
  EndInterface
  Interface VariableBox
    addMeToBoard(board)
  EndInterface
  Interface ReturnBox
    addMeToBoard(board)
  EndInterface
  Interface ClassBox
    addMeToBoard(board)
  EndInterface
  Declare newMethodBox(title.s,x,y)
  Declare newVariableBox(title.s,x,y)
  Declare newReturnBox(x,y)
  Declare newClassBox(title.s,x,y,type = 0)
EndDeclareModule
Module BOX
  
  
  XIncludeFile "CLASSES\STRUCTURE.pbi"
  
  XIncludeFile "CLASSES\METHOD.pbi"
  XIncludeFile "CLASSES\VARIABLE.pbi"
  XIncludeFile "CLASSES\RETURN.pbi"
  XIncludeFile "CLASSES\CLASS.pbi"
  
  
EndModule
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 19
; FirstLine = 6
; Folding = --
; EnableXP