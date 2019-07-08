; ***********************************************************************************************
; AUTHOR         : microDevWeb
; PROJECT        : PB BOARD
; PACKAGE        : BOARD.pbi
; ABSTRACT CLASS : BOX.pbi
; VERSION        : 1.0
; DESIGNED WITH  : PB 5.71
; DATE           : 2019/07/04
; ***********************************************************************************************
;-* PRIVATE METHODS
Procedure _BOX_calculteSize(*this._BOX,*w,*h)
  With *this
    Protected w,h
    w = VectorTextWidth(\myTitle\getTitle())
    w + \margins\left + \margins\right
    If \myIcon
      w + \myIcon\getWidht() + \margins\left
      h + \myIcon\getHeight()
    Else
      h + VectorTextHeight(\myTitle\getTitle())
    EndIf
    If \myRightIcon
      w + \myRightIcon\getWidht() + \margins\left
    EndIf
    Protected hr,hl
    ForEach \myInnerLeft()
      hl + \myInnerLeft()\getHeight()
    Next
    ForEach \myInnerRight()
      hr + \myInnerRight()\getHeight()
    Next
    If hl > hr
      h + hl
    Else
      h + hr
    EndIf
    h + \margins\below + \margins\above + 10
    Protected wl,wr,wt,wi
    ForEach \myInnerLeft()
      Define  t.BOARD::Title = \myInnerLeft()\getTitle()
      VectorFont(FontID(t\getFont()))
      wt = \myInnerLeft()\getWidht() + VectorTextWidth(t\getTitle())
      If wt > wl
        wl = wt
      EndIf
    Next
    ForEach \myInnerRight()
      Define t.BOARD::Title = \myInnerRight()\getTitle()
      VectorFont(FontID(t\getFont()))
      wt = \myInnerRight()\getWidht() + VectorTextWidth(t\getTitle())
      If wt > wr
        wr = wt
      EndIf
    Next
    wi = \margins\left + \margins\right + 20 + wl + wr
    If wi > w
      w = wi
    EndIf
    PokeL(*w,w)
    PokeL(*h,h)
  EndWith
EndProcedure

Procedure _BOX_drawInnerLeft(*this._BOX,x,y)
  With *this
    Protected xt = x,yt
    ForEach \myInnerLeft()
      MovePathCursor(x,y)
      DrawVectorImage(ImageID(\myInnerLeft()\getImage()),255,\myInnerLeft()\getWidht(),\myInnerLeft()\getHeight())
      xt + \myInnerLeft()\getWidht() + \innerMargins\left
      Protected t.BOARD::Title = \myInnerLeft()\getTitle()
      VectorFont(FontID(t\getFont()))
      yt = y +(\myInnerLeft()\getHeight() / 2) - (VectorTextHeight(t\getTitle()) / 2)
      MovePathCursor(xt,yt)
      VectorSourceColor(\myInnerColors\getFront())
      DrawVectorText(t\getTitle())
      \myInnerLeft()\setPosition(x,y,\myInnerLeft()\getWidht(),\myInnerLeft()\getHeight())
      y + \myInnerLeft()\getHeight()
    Next
  EndWith
EndProcedure

Procedure _BOX_drawInnerRight(*this._BOX,x,y)
  With *this
    Protected xt = x,yt,xi
    ForEach \myInnerRight()
      xi = x - \myInnerRight()\getWidht() - 2
      MovePathCursor(xi,y)
      DrawVectorImage(ImageID(\myInnerRight()\getImage()),255,\myInnerLeft()\getWidht(),\myInnerLeft()\getHeight())
      
      Protected t.BOARD::Title = \myInnerRight()\getTitle()
      VectorFont(FontID(t\getFont()))
      xt = xi - \innerMargins\left - VectorTextWidth(t\getTitle())
      yt = y +(\myInnerRight()\getHeight() / 2) - (VectorTextHeight(t\getTitle()) / 2)
      MovePathCursor(xt,yt)
      VectorSourceColor(\myInnerColors\getFront())
      DrawVectorText(t\getTitle())
      \myInnerRight()\setPosition(xi,y,\myInnerRight()\getWidht(),\myInnerRight()\getHeight())
      y + \myInnerRight()\getHeight()
    Next
  EndWith
EndProcedure
;}
;-* PROTECTED METHODS
Procedure _BOX_draw(*this._BOX,board.BOARD::BOARD)
  With *this
    Protected x = \myPos\x,y = \myPos\y,w,h
    ; calculate size
    VectorFont(FontID(\myTitle\getFont()))
    _BOX_calculteSize(*this,@w,@h)
    \myPos\w = w
    \myPos\h = h
    ; draw box
    AddPathBox(x,y,w,h)
    VectorSourceLinearGradient(0,y,0,y+h)
    VectorSourceGradientColor(\myColors\getBack(),0.0)
    VectorSourceGradientColor($FFDBDBDB,0.1)
    VectorSourceGradientColor(\myColors\getBack(),1)
    FillPath(#PB_Path_Preserve)
    VectorSourceColor(\myColors\getFront())
    StrokePath(0.5)
    ; calcultate txt pos
    Protected xt,yt
    xt = \margins\left + \myPos\x
    yt = \margins\above + \myPos\y
    If \myIcon
      xt + \myIcon\getWidht() + \margins\left
    EndIf
    MovePathCursor(xt,yt)
    VectorSourceColor(\myColors\getFront())
    DrawVectorText(\myTitle\getTitle())
    Protected xi = \myPos\x + \margins\right
    Protected yi = \myPos\y + \margins\above
    If \myIcon
      MovePathCursor(xi,yi)
      DrawVectorImage(ImageID(\myIcon\getImage()),255,\myIcon\getWidht(),\myIcon\getHeight())
    EndIf
    If \myRightIcon
      xi = \myPos\x +\myPos\w - \margins\right - \myRightIcon\getWidht()
      MovePathCursor(xi,yi)
      DrawVectorImage(ImageID(\myRightIcon\getImage()),255,\myRightIcon\getWidht(),\myRightIcon\getHeight())
    EndIf
    ; draw inner box
    Protected xb,yb,wb,hb
    xb = \margins\left + \myPos\x
    wb = w - \margins\left - \margins\right
    If \myIcon
      yb = \margins\above + \myIcon\getHeight() + \myPos\y + 10
      hb = h - \margins\above - \margins\below - \myIcon\getHeight() - 10
    EndIf
    AddPathBox(xb,yb,wb,hb)
    VectorSourceColor(\myInnerColors\getBack())
    FillPath()
    _BOX_drawInnerLeft(*this,xb,yb)
    _BOX_drawInnerRight(*this,xb + w - \margins\left,yb)
  EndWith
EndProcedure

Procedure _BOX_post_event(*this._BOX,board.BOARD::BOARD)
  With *this
    Protected *b._BOARD = board
    Static clickOn.b,edited.b
    Static oldX,oldY
    Static innerIcon
    ; look if event on innericon
    If gInnerStart
      ForEach \myInnerLeft()
        If \myInnerLeft()\_PostEvent(board)
          If Not gInnerStart
            gInnerLeft = #True
          EndIf
          ProcedureReturn #True
        EndIf
      Next
    EndIf
    If Not gInnerStart
      ForEach \myInnerRight()
        If \myInnerRight()\_PostEvent(board)
          If Not gInnerStart
            gInnerLeft = #False
          EndIf
          ProcedureReturn #True
        EndIf
      Next
    EndIf
    Select EventType()
      Case #PB_EventType_MouseMove
        If gMouse\x >= \myPos\x And gMouse\x <= \myPos\x + \myPos\w
          If gMouse\y >= \myPos\y And gMouse\y <= \myPos\y + \myPos\h
            If Not clickOn
              SetGadgetAttribute(*b\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Hand)
            Else
              SetGadgetAttribute(*b\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Arrows)
              Protected dx = gMouse\x - gMouse\ox
              Protected dy = gMouse\y - gMouse\oy
              Define *bo._BOARD = board
              
              If dx Or dy
                Protected nx,ny
                nx = oldX + dx
                ny = oldY + dy
                edited = #True
                Define g.BOARD::GRID = board\getGrid()
                g\manageMagnet(@nx,@ny)
                \myPos\x = nx
                \myPos\y = ny
                board\_drawMask(\myPos\x,\myPos\y,\myPos\w,\myPos\h)
              EndIf
            EndIf
            ProcedureReturn #True
          EndIf
        EndIf
      Case #PB_EventType_LeftButtonDown
        If gMouse\x >= \myPos\x And gMouse\x <= \myPos\x + \myPos\w
          If gMouse\y >= \myPos\y And gMouse\y <= \myPos\y + \myPos\h
            If Not clickOn
              gMouse\ox = gMouse\x
              gMouse\oy = gMouse\y
              oldX = \myPos\x
              oldY = \myPos\y
              clickOn = #True
            EndIf
            SetGadgetAttribute(*b\canvasId,#PB_Canvas_Cursor,#PB_Cursor_Arrows)
            ProcedureReturn #True
          EndIf
        EndIf
      Case #PB_EventType_LeftButtonUp
        clickOn = #False
        If edited
          board\_refresh()
          edited = #False
        EndIf
    EndSelect
    ProcedureReturn #False
  EndWith
EndProcedure
;}
;-* GETERS
Procedure BOX_getTitle(*this._BOX)
  With *this
    ProcedureReturn \myTitle
  EndWith
EndProcedure

Procedure BOX_getColors(*this._BOX)
  With *this
    ProcedureReturn \myColors
  EndWith
EndProcedure

Procedure BOX_getInnerColors(*this._BOX)
  With *this
    ProcedureReturn \myInnerColors
  EndWith
EndProcedure

Procedure BOX_getImage(*this._BOX)
  With *this
    ProcedureReturn \image
  EndWith
EndProcedure

Procedure BOX_getPosX(*this._BOX)
  With *this
    ProcedureReturn \myPos\x
  EndWith
EndProcedure

Procedure BOX_getPosY(*this._BOX)
  With *this
    ProcedureReturn \myPos\y
  EndWith
EndProcedure
;}
;-* SETERS
Procedure BOX_setMargins(*this._BOX,below,above,left,right)
  With *this\margins
    \below = below
    \above = above
    \left = left
    \right = right
  EndWith
EndProcedure

Procedure BOX_setInnerMargins(*this._BOX,below,above,left,right)
  With *this\innerMargins
    \below = below
    \above = above
    \left = left
    \right = right
  EndWith
EndProcedure

Procedure BOX_setIcon(*this._BOX,*icon)
  With *this
    \myIcon = *icon
  EndWith
EndProcedure
;}
;-* PUBLIC METHODS
Procedure BOX_addInnerLeft(*this._BOX,*innerIcon)
  With *this
    AddElement(\myInnerLeft())
    \myInnerLeft() = *innerIcon
    ProcedureReturn *innerIcon
  EndWith
EndProcedure

Procedure BOX_addInnerRight(*this._BOX,*innerIcon)
  With *this
    AddElement(\myInnerRight())
    \myInnerRight() = *innerIcon
    ProcedureReturn *innerIcon
  EndWith
EndProcedure

Procedure BOX_addRIghtIcon(*this._BOX,*icon)
  With *this
    \myRightIcon = *icon
    ProcedureReturn *icon
  EndWith
EndProcedure
;}
;-* CONSTRUCTOR
Procedure newBox(title.s,x,y)
  Protected *this._BOX = AllocateStructure(_BOX)
  With *this
    \methods = ?S_BOX
    \myTitle = newTitle(title,LoadFont(#PB_Any,"arial",10,#PB_Font_HighQuality|#PB_Font_Bold))
    \myColors = newColors($DB9E9E9E,$DB000000)
    \myInnerColors = newColors($FFE3E3E3,$DB000000)
    \margins\above = 5
    \margins\below = 5
    \margins\left = 5
    \margins\right = 5
    
    \innerMargins\right = 5
    \innerMargins\above = 5
    \innerMargins\below = 5
    \innerMargins\left = 5
    \innerMargins\right = 5
    
    \myPos\x = x
    \myPos\y = y
    ProcedureReturn *this
  EndWith
EndProcedure
;}
DataSection
  S_BOX:
  ; GETERS
  Data.i @BOX_getTitle()
  Data.i @BOX_getColors()
  Data.i @BOX_getInnerColors()
  Data.i @BOX_getImage()
  Data.i @BOX_getPosX()
  Data.i @BOX_getPosY()
  ; SETERS
  Data.i @BOX_setMargins()
  Data.i @BOX_setInnerMargins()
  Data.i @BOX_setIcon()
  ; PUBLIC METHODS
  Data.i @BOX_addInnerLeft()
  Data.i @BOX_addInnerRight()
  Data.i @BOX_addRIghtIcon()
  ; PROTECTED
  Data.i @_BOX_draw()
  Data.i @_BOX_post_event()
  E_BOX:
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 138
; FirstLine = 69
; Folding = PwHAAAAA-
; EnableXP