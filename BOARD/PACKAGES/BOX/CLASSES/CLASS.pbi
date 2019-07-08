; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : CLASS.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/06
; ***********************************************************************************************
;-* PUBLIC METHODS
Procedure CLASS_addMe(*this._RETURN,board.BOARD::BOARD)
  With *this
    board\addBox(\myBox)
  EndWith
EndProcedure
;
;-* CONSTRUCTOR
Procedure newClassBox(title.s,x,y,type = 0)
  Protected *this._CLASS = AllocateStructure(_CLASS)
  With *this
    \methods = ?S_CLASS
    \myBox = BOARD::newBox(title,x,y)
    Define c.BOARD::Colors = \myBox\getColors()
    Select type
      Case 0 ; normal class
        c\setBack($FFEE0000)
        \myBox\addRIghtIcon(BOARD::newIcon(gIcoStandard,24,24))
      Case 1 ; abstract
        c\setBack($FF00A5FF)
        \myBox\addRIghtIcon(BOARD::newIcon(gIcoAbstract,24,24))
      Case 2 ; static
        c\setBack($FFEE861C)
        \myBox\addRIghtIcon(BOARD::newIcon(gIcoStatic,24,24))
    EndSelect
    
    \myBox\setIcon(BOARD::newIcon(gIcoClass,24,24))
    \myChild = \myBox\addInnerLeft(BOARD::newInnerIcon(gIcoInput,12,12,"Child of"))
    \myMotherOf = \myBox\addInnerRight(BOARD::newInnerIcon(gIcoOutput,16,16,"Mother of"))
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_CLASS:
  ; PUBLIC METHODS
  Data.i @CLASS_addMe()
  E_CLASS:
EndDataSection

; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 32
; FirstLine = 14
; Folding = -
; EnableXP