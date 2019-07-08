; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : RETURN.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/06
; ***********************************************************************************************
;-* PUBLIC METHODS
Procedure RETURN_addMe(*this._RETURN,board.BOARD::BOARD)
  With *this
    board\addBox(\myBox)
  EndWith
EndProcedure
;
;-* CONSTRUCTOR
Procedure newReturnBox(x,y)
  Protected *this._RETURN = AllocateStructure(_RETURN)
  With *this
    \methods = ?S_RETURN
    \myBox = BOARD::newBox("Return",x,y)
    Define c.BOARD::Colors = \myBox\getColors()
    c\setBack($FF00CD66)
    \myBox\setIcon(BOARD::newIcon(gIcoReturn,24,24))
    \myInput = \myBox\addInnerLeft(BOARD::newInnerIcon(gIcoInput,12,12,"Input"))
    \myOutput = \myBox\addInnerRight(BOARD::newInnerIcon(gIcoOutput,16,16,"Output"))
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_RETURN:
  ; PUBLIC METHODS
  Data.i @RETURN_addMe()
  E_RETURN:
EndDataSection

; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 23
; FirstLine = 10
; Folding = -
; EnableXP