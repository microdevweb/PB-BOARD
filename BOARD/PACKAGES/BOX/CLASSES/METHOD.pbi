; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : METHOD.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* PUBLIC METHODS
Procedure METHODS_addMe(*this._METHODS,board.BOARD::BOARD)
  With *this
    board\addBox(\myBox)
  EndWith
EndProcedure
;
;-* CONSTRUCTOR
Procedure newMethodBox(title.s,x,y)
  Protected *this._METHODS = AllocateStructure(_METHODS)
  With *this
    \methods = ?S_METHODS
    \myBox = BOARD::newBox(title,x,y)
    \myBox\setIcon(BOARD::newIcon(gIcoMethod,24,24))
    \myInput = \myBox\addInnerLeft(BOARD::newInnerIcon(gIcoInput,12,12,"Input"))
    \myOutput = \myBox\addInnerRight(BOARD::newInnerIcon(gIcoOutput,16,16,"Output"))
;     \myBox\_draw()
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_METHODS:
  ; PUBLIC METHODS
  Data.i @METHODS_addMe()
  E_METHODS:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 23
; Folding = -
; EnableXP