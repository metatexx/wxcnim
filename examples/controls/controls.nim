import wxcnim
#import strutils
#import mxstring # managed WxString
#import os

type WxCustomIds = enum
  myListBox1Id = 1
  myListBox2Id

converter toWxId(x: WxCustomIds): WxId = WxId(x)

proc appMain() =
  # here our app
  wxnInitAllImageHandlers()
  let mainFrame = wxFrame(title="Hello Nim World!")
  let mainPanel = wxPanel(mainFrame, wxID_ANY, style=wxSIMPLE_BORDER)
  let mainSizer = wxBoxSizer(wxVERTICAL)
  mainSizer.addWindow(mainPanel,1, wxEXPAND)
  mainFrame.setSizer(mainSizer)
  mainFrame.setMaxSize(wxSize(800, 600))

  # creating a vertical sizer
  let vsiz = wxBoxSizer(wxVERTICAL)
  # add it to our panel in the mainFrame
  mainPanel.setSizer(vsiz)

  # Create a notebook control
  let nb=mainFrame.wxNotebook(wxID_ANY, 0, 0, -1, -1, wxNB_TOP)
  vsiz.addWindow(nb, 0, wxEXPAND)

  # Create a TextControl as log viewer
  let loggerText=mainFrame.wxTextCtrl(wxID_ANY, "This is the log window.\l",
    0, 250, 100, 50, wxTE_MULTILINE);

  vsiz.addWindow(loggerText, 1, wxEXPAND)

  proc logText(msg: string) =
    loggerText.appendText(msg & "\l")

  let choices = wxcArrayWideStrings([ "This", "is", "one of my long and",
    "wonderful", "examples."])

  # page 1
  let page1Panel = wxPanel(nb, wxID_ANY)
  if nb.addPage(page1Panel, "Page 1", true, 0):
    logText "Page 1 added"
  else:
    echo "Failed to add page 1"

  let page1Box = wxStaticBox(page1Panel, wxID_ANY, "Static Box!")
  let page1Sizer = wxStaticBoxSizer(page1Box, wxVERTICAL)
  page1Panel.setsizer(page1Sizer)

  let st1 = wxStaticText(page1Panel, wxID_ANY,
    "This is static text right aligned in panel 1", 0, 0, -1, -1, wxALIGN_RIGHT)
  page1Sizer.addWindow(st1, 0, wxEXPAND)

  # make a little gap below
  page1Sizer.add(10,10)

  # let's make a horizontal sizer to make stuff looking better :)
  let page1Sizer2 = wxBoxSizer(wxHORIZONTAL)
  page1Sizer.addSizer(page1Sizer2, 0, wxEXPAND)

  let listBox1 = wxCheckListBox(page1Panel, myListbox1Id,
    wxPoint(10,10), wxSize(120,70), 5, choices,
    wxLB_MULTIPLE or wxLB_ALWAYS_SB or wxHSCROLL )

  page1Sizer2.addWindow(listBox1)

  let listBox2 = wxCheckListBox(page1Panel, myListbox1Id,
    wxPoint(10,10), wxSize(120,70), 3, choices,
    wxLB_SORT or wxHSCROLL)

  page1Sizer2.add(0, 0, 1, wxEXPAND)

  page1Sizer2.addWindow(listBox2) #, 0, wxEXPAND)

  # page 2
  let page2Panel = wxPanel(nb, wxID_ANY)
  let page2Sizer = wxBoxSizer(wxVERTICAL)
  page2Panel.setsizer(page2Sizer)
  let grid = wxGrid(page2Panel, wxID_ANY, 0, 0, -1, -1, 0)
  grid.disableDragRowSize
  grid.createGrid(10,4, 1)
  page2Sizer.addWindow(grid, 1, wxEXPAND)

  if nb.addPage(page2Panel, "Page 2", false, 0):
    logText "Page 2 added"
  else:
    echo "Failed to add page 2"

  # page 3
  let page3Panel = wxPanel(nb, wxID_ANY)
  let page3Sizer = wxBoxSizer(wxVERTICAL)
  page3Panel.setsizer(page3Sizer)
  let bt3_1 = wxButton(page3panel, wxID_ANY, "Button", 0, 0, -1, -1, 0)
  bt3_1.connect(expEVT_COMMAND_BUTTON_CLICKED()) do (evn: WxEvent):
    logText("Button!")

  page3Sizer.addWindow(bt3_1, 1, wxEXPAND)

  if nb.addPage(page3Panel, "Page 3", false, 0):
    logText "Page 3 added"
  else:
    echo "Failed to add page 3"

  nb.connect(expEVT_COMMAND_NOTEBOOK_PAGE_CHANGED()) do(evn: WxEvent):
    let evn = WxBookCtrlEvent(evn)
    let page = evn.getSelection()
    logText("Notebook Page changed to " & $page)
    evn.skip() # we do not eat it so the page can update

  nb.connect(expEVT_COMMAND_NOTEBOOK_PAGE_CHANGING()) do(evn: WxEvent):
    let evn = WxBookCtrlEvent(evn)
    let frm = evn.getOldSelection()
    let to = evn.getSelection()
    logText("Notebook Page is going to change from " & $frm & " to " & $to)
    if frm == 2 and to == 0:
      # we veto changes from 2 directly to 0 :)
      logText("Please don't go from Page 3 to Page 1 at once!")
      evn.veto()

  # so you can't make the window smaller than the buttons sizer
  vsiz.setSizeHints(mainFrame)

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain
  # ... Mainloop running here ...
  echo "Done"
