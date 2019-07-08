; ***********************************************************************************************
; AUTHOR        : microDevWeb
; PROJECT       : PB BOARD
; PACKAGE       : BOX.pbi
; CLASS         : STRUCTURE.pbi
; VERSION       : 1.0
; DESIGNED WITH : PB 5.71
; DATE          : 2019/07/04
; ***********************************************************************************************
Global gIcoMethod = CatchImage(#PB_Any,?ICO_METHOD)
Global gIcoInput = CatchImage(#PB_Any,?ICO_INPUT)
Global gIcoOutput = CatchImage(#PB_Any,?ICO_OUTPUT)
Global gIcoVariable = CatchImage(#PB_Any,?ICO_VARIABLE)
Global gIcoReturn = CatchImage(#PB_Any,?ICO_RETURN)
Global gIcoClass = CatchImage(#PB_Any,?ICO_CLASS)
Global gIcoAbstract = CatchImage(#PB_Any,?ICO_ABSTRACT)
Global gIcoStatic = CatchImage(#PB_Any,?ICO_STATIC)
Global gIcoStandard = CatchImage(#PB_Any,?ICO_STANDARD)
Structure _METHODS
  *methods
  myBox.BOARD::BOX
  myInput.BOARD::InnerIcon
  myOutput.BOARD::InnerIcon
EndStructure
Structure _VARIABLE
  *methods
  myBox.BOARD::BOX
  myInput.BOARD::InnerIcon
  myOutput.BOARD::InnerIcon
EndStructure
Structure _RETURN
  *methods
  myBox.BOARD::BOX
  myInput.BOARD::InnerIcon
  myOutput.BOARD::InnerIcon
EndStructure
Structure _CLASS
  *methods
  myBox.BOARD::BOX
  myMotherOf.BOARD::InnerIcon
  myChild.BOARD::InnerIcon
EndStructure


DataSection
  ICO_METHOD:
  IncludeBinary "..\IMG\method.png"
  ICO_INPUT:
  IncludeBinary "..\IMG\input.png"
  ICO_OUTPUT:
  IncludeBinary "..\IMG\output.png"
  ICO_VARIABLE:
  IncludeBinary "..\IMG\variable.png"
  ICO_RETURN:
  IncludeBinary "..\IMG\return.png"
  ICO_CLASS:
  IncludeBinary "..\IMG\class.png"
  ICO_ABSTRACT:
  IncludeBinary "..\IMG\abstract.png"
  ICO_STATIC:
  IncludeBinary "..\IMG\static.png"
  ICO_STANDARD:
  IncludeBinary "..\IMG\standard.png"
EndDataSection
; IDE Options = PureBasic 5.71 beta 2 LTS (Windows - x64)
; CursorPosition = 17
; FirstLine = 6
; Folding = -
; EnableXP