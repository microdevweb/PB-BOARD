; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : VOID
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
DeclareModule BOARD
  Interface Link
    draw()
  EndInterface
  Interface Icon
    ; GETTERS
    getWidht()
    getHeight()
    getImage()
    ; SETTERS
    setWidht()
    setHeight()
    setImage()
  EndInterface
  Interface InnerIcon Extends Icon
    ; GETTERS
    getTitle()
    ; SETTERS
    setPosition(x,y,w,h)
    ; PROTECTED
    _PostEvent(board)
  EndInterface
  Interface Title
    ; GETTERS
    getTitle.s()
    getFont()
    ; SETTERS
    setTitle(title.s)
    setFont(font)
  EndInterface
  Interface Colors
    ; GETTERS
    getBack()
    getFront()
    ; SETTERS
    setBack(back)
    setFront(front)
  EndInterface
  Interface GRID
    ; GETTERS
    getSpace()
    getColor()
    ; SETTERS
    setSpace(space)
    setStartPosition(x,y)
    ; PUBLIC METHODS
    draw(output)
    PostEvent()
    manageMagnet(x,y)
  EndInterface
  Interface BOX
    ; GETERS
    getTitle()
    getColors()
    getInnerColors()
    getImage()
    getPosX()
    getPosY()
    ; SETERS
    setMargins(below,above,left,right)
    setInnerMargins(below,above,left,right)
    setIcon(icon)
    ; PUBLIC METHODS
    addInnerLeft(inner_icon)
    addInnerRight(inner_icon)
    addRIghtIcon(icon)
    ; PROTECTED METHODS
    _draw(board)
    _post_event(board)
  EndInterface
  Interface BOARD
    ; GETTERS
    getGrid()
    ; PUBLIC METHODS
    build()
    addBox(box)
    addLink(link)
    _refresh()
    _drawMask(x,y,w,h)
  EndInterface
  
  Declare newBoard(containerId)
  Declare newIcon(image,width,height)
  Declare newBox(title.s,x,y)
  Declare newInnerIcon(image,width,height,title.s)
  Declare newLink(*input,*outPut)
EndDeclareModule

Module BOARD
  EnableExplicit
  UsePNGImageDecoder()
  Structure _mouse
    x.l
    y.l
    ox.l
    oy.l
  EndStructure
  Global gZoomFactor.f = 1
  Global gMouse._mouse
  Global.BOARD::InnerIcon gInnerStart,gInnerLeft
  XIncludeFile "CLASSES\STRUCTURES.pbi"
  ; Protypes
  Declare newColors(back.l,front.l)
  Declare newGrid(canvasId.l)
  Declare newTitle(title.s,font)
  Declare superIcon(*this._ICON,*s_daughter,*E_daughter,image,width,height)
  Declare coordianteTo(x,y,*x,*y)
  
  Procedure coordianteTo(x,y,*x,*y)
    ScaleCoordinates(gZoomFactor,gZoomFactor,#PB_Coordinate_User)
    PokeL(*x,ConvertCoordinateX(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
    PokeL(*Y,ConvertCoordinateY(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
  EndProcedure
  Procedure coordianteToBis(x,y,*x,*y,canvasID)
    StartVectorDrawing(CanvasVectorOutput(canvasID))
    ScaleCoordinates(gZoomFactor,gZoomFactor,#PB_Coordinate_User)
    PokeL(*x,ConvertCoordinateX(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
    PokeL(*Y,ConvertCoordinateY(x,y,#PB_Coordinate_Device,#PB_Coordinate_User))
    StopVectorDrawing()
  EndProcedure
  XIncludeFile "CLASSES\LINK.pbi"
  XIncludeFile "CLASSES\ICON.pbi"
  XIncludeFile "CLASSES\INNER_ICON.pbi"
  XIncludeFile "CLASSES\TITLE.pbi"
  XIncludeFile "CLASSES\BOX.pbi"
  XIncludeFile "CLASSES\COLORS.pbi"
  XIncludeFile "CLASSES\GRID.pbi"
  XIncludeFile "CLASSES\BOARD.pbi"
EndModule
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 94
; FirstLine = 66
; Folding = ---
; EnableXP