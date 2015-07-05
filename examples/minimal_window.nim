import wxcnim
import strutils
import os

proc buttonQuit(fun: pointer, parent: WxWindow, evn: WxEvent) =
  if evn == nil:
    return
  eljExitMainLoop()

proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  let mainFrame = wxFrame(nil, wxID_ANY, "Hi!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)
  let sizer = wxBoxSizer(wxVertical)
  let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  var cl = wxClosure(buttonQuit, mainFrame)
  discard mainFrame.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)
  
  mainFrame.setSizer(sizer)
  sizer.addWindow(button, 0, wxALL , 10, nil)

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?


when isMainModule:
  # Initialising and running "appMain"
  let cl = wxClosure(appMain, nil) # Create Closure for appMain()
  cl.initializeC(0, nil) # Das startet alles und geht in den Loop

  # ... Mainloop running here ...

  echo "Done"
