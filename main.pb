; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; TEST          : main.pb
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
XIncludeFile "BOARD\PACKAGES\BOARD\BOARD.pbi"
XIncludeFile "BOARD\PACKAGES\BOX\BOX.pbi"

#FORM = 0
#CONTAINER = 0
Define flags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|
               #PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget
OpenWindow(#FORM,0,0,800,600,"Test",flags)
ContainerGadget(#CONTAINER,0,0,800,600,#PB_Container_BorderLess)
CloseGadgetList()
Global myBoard.BOARD::BOARD = BOARD::newBoard(#CONTAINER)
Global c.BOX::ClassBox = BOX::newClassBox("Contact",300,200)
Global ca.BOX::ClassBox = BOX::newClassBox("Person",50,100,1)
Global cs.BOX::ClassBox = BOX::newClassBox("Divers",500,300,2)


c\addMeToBoard(myBoard)
ca\addMeToBoard(myBoard)
cs\addMeToBoard(myBoard)

myBoard\build()

Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 20
; EnableXP