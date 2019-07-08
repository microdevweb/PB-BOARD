; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : ICON.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* GETTERS
Procedure ICON_getWidht(*this._ICON)
  With *this
    ProcedureReturn \width
  EndWith
EndProcedure

Procedure ICON_getHeight(*this._ICON)
  With *this
    ProcedureReturn \height
  EndWith
EndProcedure

Procedure ICON_getImage(*this._ICON)
  With *this
    ProcedureReturn \image
  EndWith
EndProcedure
;}
;-* SETTERS
Procedure ICON_setWidht(*this._ICON,width)
  With *this
     \width = width
  EndWith
EndProcedure

Procedure ICON_setHeight(*this._ICON,height)
  With *this
     \height = height
  EndWith
EndProcedure

Procedure ICON_setImage(*this._ICON,image)
  With *this
     \image = image
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newIcon(image,width,height)
  Protected *this._ICON = AllocateStructure(_ICON)
  With *this
    \methods = ?S_ICON
    \image = image
    \width = width
    \height = height
    ProcedureReturn *this
  EndWith
EndProcedure

Procedure superIcon(*this._ICON,*s_daughter,*E_daughter,image,width,height)
  With *this
    ; allouer la mémoire
    Protected motherLen = ?E_ICON - ?S_ICON,daughterLen = *E_daughter - *s_daughter
    \methods = AllocateMemory(motherLen + daughterLen)
    ; empiler les adresses des méthodes
    MoveMemory(?S_ICON,\methods,motherLen)
    MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
    ; set values
    \image = image
    \width = width
    \height = height
  EndWith
EndProcedure
;}


DataSection
  S_ICON:
  ; GETTERS
  Data.i @ICON_getWidht()
  Data.i @ICON_getHeight()
  Data.i @ICON_getImage()
  ; SETTERS
  Data.i @ICON_setWidht()
  Data.i @ICON_setHeight()
  Data.i @ICON_setImage()
  E_ICON:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 59
; FirstLine = 9
; Folding = Q1
; EnableXP