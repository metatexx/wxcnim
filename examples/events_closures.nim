import wxcnim
import strutils
import os

var timecounter = 0
var timerWx: WxTimer = nil
var timerEx: WxTimerEx = nil

proc appMain() =
  let mainFrame = wxFrame(nil, wxID_ANY, "Hi!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)
  #echo "parent: ", mainFrame.repr

  let sizer = wxBoxSizer(wxVertical)
  let button = wxButton(mainFrame, -12, "Quit", 0,0, -1,-1, 0)

  button.register(proc (event: WxEvent) = eljExitMainLoop())

  let panel = wxPanel(mainFrame, wxID_ANY)
  panel.register(expEVT_KEY_UP()) do (evn: WxEvent):
    let evn = WxKeyEvent(evn)
    if evn == nil:
      return
    echo "keyPressed (on Button)..."
    echo "type: ", evn.getEventType
    echo "ts: ", evn.getTimestamp
    echo "id: ", evn.getId
    echo "KeyCode: ", wxKeyEvent_GetKeyCode(evn)
    echo "Modifiers: ", wxKeyEvent_GetModifiers(evn)
    if wxKeyEvent_GetKeyCode(evn)==67 and wxKeyEvent_GetModifiers(evn)==16:
      # ctrl+c :)
      eljExitMainLoop()

  mainFrame.setSizer(sizer)
  sizer.addWindow(button, 0, wxALL, 10, nil)

  # new timer owned by mainFrame
  timerWx = wxTimer(mainFrame, wxID_ANY)
  # add event listener for timer events to mainFrame
  mainFrame.register(expEVT_TIMER(), proc (evn: WxEvent) =
    echo "One shot TimerWx Boom!")
  # start the timer as one shot after 5 seconds
  discard timerWx.start(5000, true)

  # this is just "a timer" with a callback not bound to anything really
  timerEx = wxTimerEx()
  timerEx.register proc(evn: WxEvent) {.nimcall.} =
    if evn == nil:
      return
    let evn = WxTimerEvent(evn)

    inc timecounter
    echo "Its about time #", timecounter, " (interval is ", evn.getInterval, " milliseconds)"

    if timecounter == 4:
      discard timerEx.start(500)

    if timecounter == 8:
      discard timerEx.start(250)

    if timecounter == 16:
      #timerEx.stop()
      timerEx.delete()
      echo "timerEx stopped"
  discard timerEx.start(1000, false)

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?


when isMainModule:
  callMain appMain
  # ... Mainloop running here ...
  echo "Done"
