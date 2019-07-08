; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : COLORS.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* GETTERS
Procedure COLORS_getBack(*this._COLORS)
  With *this
    ProcedureReturn \back
  EndWith
EndProcedure

Procedure COLORS_getFront(*this._COLORS)
  With *this
    ProcedureReturn \front
  EndWith
EndProcedure
;}

;-* SETTERS
Procedure COLORS_setBack(*this._COLORS,back)
  With *this
    \back = back
  EndWith
EndProcedure

Procedure COLORS_setFront(*this._COLORS,front)
  With *this
    \front = front
  EndWith
EndProcedure
;}

;-* PROTECTED CONSTRUCTOR
Procedure newColors(back.l,front.l)
  Protected *this._COLORS = AllocateStructure(_COLORS)
  With *this 
    \methods = ?S_COLORS
    \back = back
    \front = front
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_COLORS:
  ; GETTERS
  Data.i @COLORS_getBack()
  Data.i @COLORS_getFront()
  ; SETTERS
  Data.i @COLORS_setBack()
  Data.i @COLORS_setFront()
  E_COLORS:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 41
; FirstLine = 18
; Folding = H-
; EnableXP