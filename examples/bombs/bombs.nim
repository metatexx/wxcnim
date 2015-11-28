import wxcnim

import strutils
import os

include icon_data

var panel: WxPanel

proc buttonQuit(fun: pointer, parent: WxWindow, evn: WxEvent) =
  if evn == nil:
    return
  eljExitMainLoop()

proc onPaint(fun: pointer, parent: WxWindow, evn: WxEvent) =
  if evn == nil:
    return

  #let dc = wxClientDC(panel)
  let dc = wxPaintDC(panel)
  echo repr(cast[int](dc))

  let colBlue = wxColourByName("Blue")
  let bluePen = wxPen_CreateFromColour(colBlue, 2, wxSOLID)

  let colRed = wxColourByName("Red")
  let blueBrush = wxBrush_CreateFromColour(colRed, wxSolid)

  dc.setPen(bluePen)
  dc.setBrush(blueBrush)
  dc.drawCircle(100, 100, 50)
  dc.drawLine(0,0, 300,300)

proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(
  
  eljInitAllImageHandlers()
  
  let mainFrame = wxFrame(nil, wxID_ANY, "Nim Bombs!", -1, -1, 300, 300, wxDEFAULT_DIALOG_STYLE or wxMINIMIZE_BOX)

  let bmp = wxBitmapFromXPM(addr icon_data[0])

  #let icon = wxIconFromXPM(addr icon_data[0])
  #wxIcon_CopyFromBitmap(icon, bmp)
  #wxTopLevelWindow_SetIcon(mainFrame, icon);

  let sizer = wxBoxSizer(wxVertical)
  let button = wxBitmapButton(mainFrame, wxID_ANY, bmp, 0, 0, -1, -1, wxBORDER_NONE)

  #let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  var cl = wxClosure(buttonQuit, mainFrame)
  discard mainFrame.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)
  
  mainFrame.setSizer(sizer)

  panel = wxPanel(mainFrame, wxID_ANY, 0,0, -1,-1, wxBORDER_RAISED)

  sizer.addWindow(panel, 1, wxALL or wxEXPAND, 10, nil)
  sizer.addWindow(button, 0, wxALL, 10, nil)

  var paintcl = wxClosure(onPaint, panel)
  discard panel.connect(-1, -1, expEVT_PAINT(), paintcl)

  #mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

when isMainModule:
  # Initialising and running "appMain"
  let cl = wxClosure(appMain, nil) # Create Closure for appMain()
  cl.initializeC(0, nil) # Das startet alles und geht in den Loop

  # ... Mainloop running here ...

  echo "Done"
