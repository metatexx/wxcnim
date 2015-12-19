import wxcnim
import strutils
import os

proc buttonQuit(evn: WxEvent) =
  wxnExitMainLoop()

proc appMain() =
  let mainFrame = wxFrame(nil, wxID_ANY, "Hi!", -1, -1, 800, 600, wxDEFAULT_FRAME_STYLE)
  let sizer = wxBoxSizer(wxVertical)
  let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  mainFrame.connect(expEVT_COMMAND_BUTTON_CLICKED(), buttonQuit)

  mainFrame.setSizer(sizer)

  let grid = wxGrid(mainFrame, wxID_ANY, 0, 0, -1, -1, 0)

  grid.disableDragRowSize

  grid.createGrid(10,4, 1)

  grid.setCellValue(0,0, "Read only!")
  grid.setCellValue(0,1, "Kölle")
  grid.setCellValue(0,2, "Alaaf!")
  grid.setCellValue(1,0, "1")
  grid.setCellValue(1,1, "2")
  grid.setCellValue(1,2, "3")

  grid.setCellTextColour(0,0, wxColourRGB(255,0,0))

  grid.setReadOnly(0 , 0, true)

  var ss = wxcArrayWideStrings(["Kölle", "Alaaf!"])

  # only allows data from the list of strings
  let ged_ro = wxGridCellChoiceEditor_Ctor(ss.len, ss, true)
  grid.setCellEditor(0 , 1, ged_ro)


  sizer.addWindow(grid, 0, wxALL, 10, nil)
  sizer.addWindow(button, 0, wxALL, 10, nil)

  #mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?


when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain

  # ... Mainloop running here ...

  echo "Done"
