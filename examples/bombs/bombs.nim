import wxcnim

import strutils
import os

include icon_data

var panel: WxPanel

proc buttonQuit(evn: WxEvent) =
  wxnExitMainLoop()

proc onPaint(evn: WxEvent) =
  let dc = wxPaintDC(panel) # PaintDC because we are in PaintEvent

  let redBrush = wxBrush(wxColourByName("Red"), wxSolid)
  # yet a shorter way
  #let bluePen = wxPen("Blue", 2, wxSolid)
  # should work with the "or" type from nimdefs too
  #let bluePen = wxPen("Blue", 2, wxPENSTYLE_SOLID)
  let bluePen = wxPen("Blue", 2)

  dc.setPen(bluePen)
  dc.setBrush(redBrush)
  dc.drawCircle(100, 100, 50)
  dc.drawLine(0,0, 300,300)

  # we need to delete it (if not we get drawing artefacts)
  dc.delete()

proc appMain() =
  wxnInitAllImageHandlers()

  let mainFrame = wxFrame(title="Nim Bombs!", w=300, h=300,
    stl = wxDEFAULT_DIALOG_STYLE or wxMINIMIZE_BOX or wxRESIZE_BOX)

  let bmp = wxBitmapFromXPM(addr icon_data[0])

  #let icon = wxIconFromXPM(addr icon_data[0])
  #wxIcon_CopyFromBitmap(icon, bmp)
  #wxTopLevelWindow_SetIcon(mainFrame, icon);

  let sizer = wxBoxSizer(wxVertical)
  let button = wxBitmapButton(mainFrame, wxID_ANY, bmp, 0, 0, -1, -1, wxBORDER_NONE)

  #let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  mainFrame.connect(expEVT_COMMAND_BUTTON_CLICKED(), buttonQuit)

  mainFrame.setSizer(sizer)

  panel = wxPanel(mainFrame, wxID_ANY, 0,0, -1,-1, wxBORDER_RAISED)

  #let dc = wxClientDC(panel)

  sizer.addWindow(panel, 1, wxALL or wxEXPAND, 10, nil)
  sizer.addWindow(button, 0, wxALL, 10, nil)

  panel.connect(expEVT_PAINT(), onPaint)

  #mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain
  # ... Mainloop running here ...
  echo "Done"
