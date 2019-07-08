; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : VARIABLE.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* PUBLIC METHODS
Procedure VARIABLE_addMe(*this._METHODS,board.BOARD::BOARD)
  With *this
    board\addBox(\myBox)
  EndWith
EndProcedure
;
;-* CONSTRUCTOR
Procedure newVariableBox(title.s,x,y)
  Protected *this._METHODS = AllocateStructure(_METHODS)
  With *this
    \methods = ?S_VARIABLE
    \myBox = BOARD::newBox(title,x,y)
    Define c.BOARD::Colors = \myBox\getColors()
    c\setBack($FFCDC57A)
    \myBox\setIcon(BOARD::newIcon(gIcoVariable,24,24))
    \myInput = \myBox\addInnerLeft(BOARD::newInnerIcon(gIcoInput,12,12,"Input"))
    \myOutput = \myBox\addInnerRight(BOARD::newInnerIcon(gIcoOutput,16,16,"Output"))
;     \myBox\_draw()
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_VARIABLE:
  ; PUBLIC METHODS
  Data.i @METHODS_addMe()
  E_VARIABLE:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 23
; FirstLine = 16
; Folding = -
; EnableXP