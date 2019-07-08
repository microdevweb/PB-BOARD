; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOARD.pbi
; CLASS         : STRUCTURES.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************

Structure _COLORS
  *methods
  back.l
  front.l
EndStructure
Structure _TITLE
  *methods
  title.s
  font.l
EndStructure
Structure _POS
  x.l
  y.l
  w.l
  h.l
EndStructure

Structure _ICON
  *methods
  image.l
  width.l
  height.l
EndStructure
Structure _INNER_ICON Extends _ICON
  title.BOARD::Title
  myPos._POS
EndStructure
Structure _GRID
  *methods
  space.l
  sensitive.l
  canvasId.l
  zoomFactor.f
  myColors.BOARD::Colors
  mask.l
  startX.l
  startY.l
EndStructure

Structure _MARGINS
  left.l
  right.l
  above.l
  below.l
EndStructure

Structure _LINK
  *methods
  *outPut._INNER_ICON
  *inPut._INNER_ICON
EndStructure

Structure _BOX
  *methods
  myTitle.BOARD::Title
  myColors.BOARD::Colors
  myInnerColors.BOARD::Colors
  myIcon.BOARD::Icon
  myRightIcon.BOARD::Icon
  margins._MARGINS
  innerMargins._MARGINS
  myPos._POS
  List myInnerLeft.BOARD::InnerIcon()
  List myInnerRight.BOARD::InnerIcon()
  image.l
EndStructure

Structure _BOARD
  *methods
  VscrollId.l
  HscrollId.l
  canvasId.l
  mask.l
  myGrid.BOARD::GRID
  List myBoxes.BOARD::Box()
  List myLink.BOARD::Link()
EndStructure

; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 69
; FirstLine = 57
; Folding = --
; EnableXP