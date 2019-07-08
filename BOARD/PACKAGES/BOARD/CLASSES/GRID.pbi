; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : GRID.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
;-* PRIVATE METHODS

Procedure _GRID_build(*this._GRID)
  With *this
    StartVectorDrawing(ImageVectorOutput(\mask))
    Protected w,h
    coordianteTo(ImageWidth(\mask),ImageHeight(\mask),@w,@h)
; eraze canvas
;     Protected w = ImageWidth(\mask),h = ImageHeight(\mask)
    VectorSourceColor(\myColors\getBack())
    FillVectorOutput()
    ; draw columns
    Protected c
    While c < w
      MovePathCursor(c + \startX,0 + \startY)
      AddPathLine(c + \startX,h + \startY)
      c + \space
    Wend
    ; draw rows
    Protected r
    While r < h
      MovePathCursor(0 + \startX,r + \startY)
      AddPathLine(w + \startX,r + \startY)
      r + \space
    Wend
    VectorSourceColor(\myColors\getFront())
    StrokePath(0.5)
    StopVectorDrawing()
  EndWith
EndProcedure

;}
;-* PRUBLIC METHODS
Procedure GRID_draw(*this._GRID,output)
  With *this
    If output
      StartVectorDrawing(ImageVectorOutput(output))
    EndIf
    VectorSourceImage(ImageID(\mask))
    FillVectorOutput()
    If output
      StopVectorDrawing()
    EndIf
  EndWith
EndProcedure

Procedure GRID_postEvent(*this._GRID)
  With *this
    Select EventType()
      Case #PB_EventType_MouseWheel
        If GetGadgetAttribute(\canvasId,#PB_Canvas_Modifiers) = #PB_Canvas_Control
          Select  GetGadgetAttribute(\canvasId,#PB_Canvas_WheelDelta)
            Case 1
              If gZoomFactor < 15
                gZoomFactor + 0.1
                _GRID_build(*this)
                ProcedureReturn #True
              EndIf
            Case -1
              If gZoomFactor > 0.5
                gZoomFactor - 0.1
                _GRID_build(*this)
                ProcedureReturn #True
              EndIf
          EndSelect
        EndIf
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure

Procedure GRID_manageMagnet(*this._GRID,*x,*y)
  ; gestion de l'aimantation
  With *this
    Protected x = PeekL(*x),y = PeekL(*y),lM.f =  \space - \sensitive,LP.f = \sensitive
    If Mod(PeekL(*x),\space) >= LM
      x =  Round(PeekL(*x)/\space,#PB_Round_Up) * \space
    ElseIf Mod(PeekL(*x),\space) <= LP
      x =  Round(PeekL(*x)/\space,#PB_Round_Nearest) * \space
    EndIf
    If Mod(PeekL(*y),\space) >= LM
      Y =  Round(PeekL(*y)/\space,#PB_Round_Up) * \space
    ElseIf Mod(PeekL(*y),\space) <= LP
      Y =  Round(PeekL(*y)/\space,#PB_Round_Nearest) * \space
    EndIf
    
    PokeL(*x,x)
    PokeL(*y,y)
  EndWith
EndProcedure
;}

;-* GETTERS
Procedure GRID_getSpace(*this._GRID)
  With *this
    ProcedureReturn \space
  EndWith
EndProcedure

Procedure GRID_getColor(*this._GRID)
  With *this
    ProcedureReturn \myColors
  EndWith
EndProcedure
;}

;-* SETTERS
Procedure GRID_setSpace(*this._GRID,space)
  With *this
    \space = space
  EndWith
EndProcedure

Procedure GRID_setStartPosition(*this._GRID,x,y)
  With *this
    \startX = x
    \startY = y
  EndWith
EndProcedure

;}
;-* PROTECTED CONSTRUCTOR
Procedure newGrid(canvasId.l)
  Protected *this._GRID = AllocateStructure(_GRID)
  With *this
    \methods = ?S_GRID
    \space = 10
    \sensitive = 2
    \myColors = newColors($FF575757,$DB696969)
    \canvasId = canvasId
    \zoomFactor = 1
    ; create mask image
    \mask = CreateImage(#PB_Any,GadgetWidth(\canvasId),GadgetHeight(\canvasId))
    _GRID_build(*this)
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_GRID:
  ; GETTERS
  Data.i @GRID_getSpace()
  Data.i @GRID_getColor()
  ; SETTERS
  Data.i @GRID_setSpace()
  Data.i @GRID_setStartPosition()
  ; PUBLIC METHODS
  Data.i @GRID_draw()
  Data.i @GRID_postEvent()
  Data.i @GRID_manageMagnet()
  E_GRID:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 136
; FirstLine = 114
; Folding = --z-
; EnableXP