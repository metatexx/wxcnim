import wxcnim
import strutils
import os

proc buttonQuit(evn: WxEvent) {.nimcall.} =
  wxnExitMainLoop()

proc appMain() =
  # argc und argv do not make sense to me :(

  let mainFrame = wxFrame(nil, wxID_ANY, "Hi!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)
  let sizer = wxBoxSizer(wxVertical)
  let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  mainFrame.connect(expEVT_COMMAND_BUTTON_CLICKED(), buttonQuit)

  mainFrame.setSizer(sizer)
  sizer.addWindow(button, 0, wxALL , 10, nil)

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?


when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain

  # ... Mainloop running here ...

  echo "Done"
