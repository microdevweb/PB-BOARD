; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : BOARD.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************

;-* PRIVATE METHODS
Procedure _BOARD_DRAWMASK(*this._BOARD,x = 0,y = 0, w = 0, h = 0)
  With *this
    StartVectorDrawing(CanvasVectorOutput(\canvasId))
    VectorSourceImage(ImageID(\mask))
    FillVectorOutput()
    If w And h
      ScaleCoordinates(gZoomFactor,gZoomFactor,#PB_Coordinate_User)
      VectorSourceColor($63FF901E)
      AddPathBox(x,y,w,h)
      FillPath()
    EndIf
    StopVectorDrawing()
  EndWith
EndProcedure

Procedure _BOARD_draw(*this._BOARD)
  With *this
    StartVectorDrawing(ImageVectorOutput(\mask))
    ScaleCoordinates(gZoomFactor,gZoomFactor,#PB_Coordinate_User)
    Protected w,h,x,y
    \myGrid\draw(0)
    ForEach \myBoxes()
      \myBoxes()\_draw(*this)
    Next
    ForEach \myLink()
      \myLink()\draw()
    Next
    StopVectorDrawing()
    _BOARD_DRAWMASK(*this)
  EndWith
EndProcedure

Procedure _BOARD_drawLine(*this._BOARD,x,y) 
  With *this
    Define *i._INNER_ICON = gInnerStart
    Protected x1 = *i\myPos\x
    Protected y1 = *i\myPos\y + (*i\myPos\h / 2)
    Protected x2,y2,x3,y3
    If gInnerLeft
      x1 - (*i\myPos\w / 2)
    Else
      x1 + (*i\myPos\w / 2)
    EndIf
    StartVectorDrawing(CanvasVectorOutput(\canvasId))
    VectorSourceImage(ImageID(\mask))
    FillVectorOutput()
    ScaleCoordinates(gZoomFactor,gZoomFactor,#PB_Coordinate_User)
    MovePathCursor(x1,y1)
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
    AddPathCurve(x2,y1,x3,y,x,y)
    VectorSourceColor($FF00D7FF)
    StrokePath(2)
;     AddPathBox(x2,y1,10,10)
;     AddPathBox(x3,y,10,10)
;     FillPath()
    StopVectorDrawing()
  EndWith
EndProcedure

Procedure _BOARD_event()
  Protected *this._BOARD = GetGadgetData(EventGadget())
  With *this
    Protected mX,mY
   coordianteToBis(GetGadgetAttribute(\canvasId,#PB_Canvas_MouseX),
                   GetGadgetAttribute(\canvasId,#PB_Canvas_MouseY),
                   @mx,@my,\canvasId)
   gMouse\x = mx
   gMouse\y = my
    Select EventType()
      Case #PB_EventType_MouseMove
        If gInnerStart
          _BOARD_drawLine(*this,mx,my)
        EndIf
      Case #PB_EventType_MouseEnter
        SetActiveGadget(\canvasId)
      Case #PB_EventType_MouseWheel
        If \myGrid\PostEvent()
          _BOARD_draw(*this)
        EndIf
    EndSelect
    SetGadgetAttribute(\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Default)
    ForEach \myBoxes()
      If \myBoxes()\_post_event(*this) : Break : EndIf
    Next
  EndWith
EndProcedure
;}
;-* GETTERS
Procedure BOARD_getGrid(*this._BOARD)
  With *this
    ProcedureReturn \myGrid
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure BOARD_build(*this._BOARD)
  With *this
    _BOARD_draw(*this)
  EndWith
EndProcedure

Procedure BOARD_addBox(*this._BOARD,*box)
  With *this
    AddElement(\myBoxes())
    \myBoxes() = *box
    ProcedureReturn *box
  EndWith
EndProcedure

Procedure BOARD_addLink(*this._BOARD,*link)
  With *this
    AddElement(\myLink())
    \myLink() = *link
    ProcedureReturn *link
  EndWith
EndProcedure

;}

Procedure newBoard(containerId)
  Protected *this._BOARD = AllocateStructure(_BOARD)
  With *this
    \methods = ?S_BOARD
    OpenGadgetList(containerId)
    \canvasId = CanvasGadget(#PB_Any,0,0,GadgetWidth(containerId),GadgetHeight(containerId),
                             #PB_Canvas_Keyboard|#PB_Canvas_Container)
    \mask = CreateImage(#PB_Any,GadgetWidth(\canvasId),GadgetHeight(\canvasId))
    \VscrollId = ScrollBarGadget(#PB_Any,0,GadgetHeight(containerId) - 20,
                                 GadgetWidth(containerId) - 20,20,0,0,10)
    \HscrollId = ScrollBarGadget(#PB_Any,GadgetWidth(containerId) - 20,0,
                                 20,GadgetHeight(containerId) - 20,0,0,10,#PB_ScrollBar_Vertical)
    HideGadget(\VscrollId,#True)
    HideGadget(\HscrollId,#True)
    CloseGadgetList()
    CloseGadgetList()
    \myGrid = newGrid(\canvasId)
    ; push event management
    SetGadgetData(\canvasId,*this)
    BindGadgetEvent(\canvasId,@_BOARD_event())
    ProcedureReturn *this
  EndWith
EndProcedure

DataSection
  S_BOARD:
  ; GETTERS
  Data.i @BOARD_getGrid()
  ; PUBLIC METHODS
  Data.i @BOARD_build()
  Data.i @BOARD_addBox()
  Data.i @BOARD_addLink()
  Data.i @_BOARD_draw()
  Data.i @_BOARD_DRAWMASK()
  
  E_BOARD:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 36
; FirstLine = 18
; Folding = ----
; EnableXP