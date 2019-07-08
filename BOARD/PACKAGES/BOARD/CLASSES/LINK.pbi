; ***********************************************************************************************
; AUTHOR         : microDevWeb
; PROJECT        : PB BOARD
; PACKAGE        : BOARD.pbi
; ABSTRACT CLASS : LINK.pbi
; VERSION        : 1.0
; DESIGNED WITH  : PB 5.71
; DATE           : 2019/07/04
; ***********************************************************************************************

Procedure LINK_draw(*this._LINK)
  With *this
    Protected x = \outPut\myPos\x
    Protected y = \outPut\myPos\y + (\outPut\myPos\h / 2)
    Protected x1 = \inPut\myPos\x
    Protected y1 = \inPut\myPos\y + (\inPut\myPos\h / 2)
    Protected x2,y2,x3,y3
    If x1 < x
      x1 + (\inPut\myPos\w / 2)
      x + (\outPut\myPos\w / 2)
    Else
      x1 + (\inPut\myPos\w / 2)
      x - (\outPut\myPos\w / 2)
    EndIf
    If x > x1
      x2 = x1 + ((x - x1) * 0.5)
      x3 = x - ((x - x1) * 0.5)
    Else
      x2 = x1 -  ((x1 - x) * 0.5)
      x3 = x + ((x - x1) * 0.5)
    EndIf
    If y > y1
      y2 = y1 - ((y -  y1) * 0.5)
    Else
      y2 = y1 + ((y1 -  y) * 0.5)
    EndIf
    MovePathCursor(x1,y1)
    AddPathCurve(x2,y1,x3,y,x,y)
    VectorSourceColor($FF00D7FF)
    StrokePath(2)
  EndWith
EndProcedure

Procedure newLink(*input,*outPut)
  Protected *this._LINK = AllocateStructure(_LINK)
  With *this
    \methods = ?S_LINK
    \inPut = *input
    \outPut = *outPut
    ProcedureReturn *this
  EndWith
EndProcedure

DataSection
  S_LINK:
  Data.i @LINK_draw()
  E_LINK:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 17
; FirstLine = 10
; Folding = -
; EnableXP