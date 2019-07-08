; ***********************************************************************************************
; AUTHOR         : microDevWeb
; PROJECT        : PB BOARD
; PACKAGE        : BOARD.pbi
; ABSTRACT CLASS : TITLE.pbi
; VERSION        : 1.0
; DESIGNED WITH  : PB 5.71
; DATE           : 2019/07/04
; ***********************************************************************************************
;-* GETTERS
Procedure.s TITLE_getTitle(*this._TITLE)
  With *this
    ProcedureReturn \title
  EndWith
EndProcedure

Procedure TITLE_getFont(*this._TITLE)
  With *this
    ProcedureReturn \font
  EndWith
EndProcedure
;
;-* SETTERS
Procedure TITLE_setTitle(*this._TITLE,title.s)
  With *this
    \title = title
  EndWith
EndProcedure

Procedure TITLE_setFont(*this._TITLE,font)
  With *this
    \font = font
  EndWith
EndProcedure
;


;-* PROTECTED CONSTRUCTOR
Procedure newTitle(title.s,font)
  Protected *this._TITLE = AllocateStructure(_TITLE)
  With *this
    \methods = ?S_TITLE
    \title = title
    \font = font
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_TITLE:
  ; GETTERS
  Data.i @TITLE_getTitle()
  Data.i @TITLE_getFont()
  ; SETTERS
  Data.i @TITLE_setTitle()
  Data.i @TITLE_setFont()
  E_TITLE:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 37
; FirstLine = 12
; Folding = J-
; EnableXP