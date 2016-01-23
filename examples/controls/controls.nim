import wxcnim
#import strutils
#import mxstring # managed WxString
#import os

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
  let loggerText=mainFrame.wxTextCtrl(wxID_ANY, "This is the log window.\n",
    0, 250, 100, 50, wxTE_MULTILINE);

  vsiz.addWindow(loggerText, 1, wxEXPAND)

  proc logText(msg: string) =
    loggerText.appendText(msg)

  # page 1
  let page1Panel = wxPanel(nb, wxID_ANY)
  if nb.addPage(page1Panel, "Page 1", true, 0):
    logText "Page 1 added\n"
  else:
    echo "Failed to add page 1"

  let page1Box = wxStaticBox(page1Panel, wxID_ANY, "Static Box!")
  let page1Sizer = wxStaticBoxSizer(page1Box, wxVERTICAL)
  page1Panel.setsizer(page1Sizer)

  let st1 = wxStaticText(page1Panel, wxID_ANY,
    "This is static text in panel 1", 0, 0, -1, -1, wxALIGN_RIGHT)
  page1Sizer.addWindow(st1, 1, wxEXPAND)

  # page 2
  let page2Panel = wxPanel(nb, wxID_ANY)
  let page2Sizer = wxBoxSizer(wxVERTICAL)
  page2Panel.setsizer(page2Sizer)
  let grid = wxGrid(page2Panel, wxID_ANY, 0, 0, -1, -1, 0)
  grid.disableDragRowSize
  grid.createGrid(10,4, 1)
  page2Sizer.addWindow(grid, 1, wxEXPAND)

  if nb.addPage(page2Panel, "Page 2", false, 0):
    logText "Page 2 added\n"
  else:
    echo "Failed to add page 2"

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
