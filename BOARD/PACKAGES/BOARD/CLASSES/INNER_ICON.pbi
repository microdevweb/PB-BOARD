; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : INNER_ICON.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* GETTERS
Procedure INNER_ICON_getTitle(*this._INNER_ICON)
  With *this
    ProcedureReturn \title
  EndWith
EndProcedure
;}
;-* SETTERS
Procedure INNER_ICON_setPosition(*this._INNER_ICON,x,y,w,h)
  With *this\myPos
    \x = x
    \y = y
    \w = w
    \h = h
  EndWith  
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _INNER_ICON_PostEvent(*this._INNER_ICON,board.BOARD::BOARD)
  With *this
    Static *hovered
    Static clickOn.b
    Select EventType()
      Case #PB_EventType_MouseMove
        If gMouse\x >= \myPos\x And gMouse\x <= \myPos\x + \myPos\w
          If gMouse\y >= \myPos\y And gMouse\y <= \myPos\y + \myPos\h
            Define *b._BOARD = board
            SetGadgetAttribute(*b\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Cross)
            *hovered = *this
            ProcedureReturn #True
          EndIf
        EndIf
        *hovered = 0
      Case #PB_EventType_LeftButtonDown
        If Not clickOn
          If *hovered
            If Not gInnerStart
              gInnerStart = *hovered
            ElseIf gInnerStart
              board\addLink(BOARD::newLink(gInnerStart,*hovered))
              gInnerStart = 0
              board\_refresh()
            EndIf
          EndIf
          clickOn = #True
        EndIf
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newInnerIcon(image,width,height,title.s)
  Protected *this._INNER_ICON = AllocateStructure(_INNER_ICON)
  With *this
    superIcon(*this,?S_INNER_ICON,?E_INNER_ICON,image,width,height)
    \title = newTitle(title,LoadFont(#PB_Any,"arial",8,#PB_Font_HighQuality))
    ProcedureReturn *this
  EndWith
EndProcedure
;}

DataSection
  S_INNER_ICON:
  ; GETTERS
  Data.i @INNER_ICON_getTitle()
  ; SETTERS
  Data.i @INNER_ICON_setPosition()
  ; PROTECTED
  Data.i @_INNER_ICON_PostEvent()
  E_INNER_ICON:
EndDataSection

; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 46
; FirstLine = 27
; Folding = ---
; EnableXP