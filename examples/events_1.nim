import wxcnim
import strutils
import os

proc keyPressed(fun: pointer, parent: WxWindow, evn: WxKeyEvent) =
  if evn == nil:
    return
  echo "keyPressed (on Button)..."
  echo "type: ", evn.getEventType
  echo "ts: ", evn.getTimestamp
  echo "obj: ", evn.getEventObject.repr
  echo "id: ", evn.getId
  echo "KeyCode: ", wxKeyEvent_GetKeyCode(evn)
  echo "Modifiers: ", wxKeyEvent_GetModifiers(evn)
  
  if wxKeyEvent_GetKeyCode(evn)==67 and wxKeyEvent_GetModifiers(evn)==16:
    # ctrl+c :)
    eljExitMainLoop()


proc buttonPressed(fun: pointer, parent: WxWindow, evn: WxEvent) =
  if evn == nil:
    return
  echo "buttonPressed (on mainFrame)..."
  echo "type: ", evn.getEventType
  echo "ts: ", evn.getTimestamp
  echo "obj: ", evn.getEventObject.repr
  echo "id: ", evn.getId
  evn.skip() # makes that the other one still gets called!

proc buttonQuit(fun: pointer, parent: WxWindow, evn: WxEvent) =
  if evn == nil:
    return

  echo "buttonQuit (on Button)..."
  echo "type: ", evn.getEventType
  echo "ts: ", evn.getTimestamp
  echo "obj: ", evn.getEventObject.repr
  echo "id: ", evn.getId

  evn.skip() # makes that the other one still gets called!
  eljExitMainLoop()

proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  let mainFrame = wxFrame(nil, wxID_ANY, "Hi!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)
  echo "parent: ", mainFrame.repr

  let sizer = wxBoxSizer(wxVertical)
  let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  discard button.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), wxClosure(buttonPressed, mainFrame))
  discard mainFrame.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), wxClosure(buttonQuit, mainFrame))
  discard button.connect(-1, -1, expEVT_KEY_UP(), wxClosure(keyPressed, mainFrame))

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
