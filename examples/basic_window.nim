# Simples wxWidgets Beispiel
# Benutzt using wxc

import wxcnim
import strutils
import os

type WxCustomIds = enum
  myScrolledId = 1
  myGridId

converter toWxId(x: WxCustomIds): WxId = WxId(x)

proc makeButton(parent: WxFrame, text: string, cb: proc (fun: WxClosure, parent: WxWindow, evn: pointer)): WxButton =
  result = wxButton(parent, wxID_ANY, text, 0, 0, -1, -1, 0)
  var cl = wxClosure(cb, parent)
  #echo "cl: ", result.repr
  discard result.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)

#import mxstring (not needed atm)

proc myMenuNew(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return
  echo "Menu Event: ", evn.repr
  echo "Menu Data: ", data.repr
  # bell (wau wau)

  var grid = WxGrid(eljFindWindowById(myGridId, nil))

  grid.beginBatch()
  for r in 1..9:
    for i in 0..4:
      grid.setCellValue(r, i, $(i+1+r*10))
  grid.endBatch()

  eljBell()

proc myMenuOpen(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return
  let dir = eljGetUserHome(eljGetUserName())

  let fileDlg = wxFileDialog(nil, "Select a text file (*.txt)!",
    dir,  "test.txt",  "Text Files|*.txt", stl=wxFD_OPEN)
  if fileDlg.showModal() != wxID_CANCEL:
    echo "File selected: ", fileDlg.getPath()
  else:
    echo "File selection canceled"

  echo if fileDlg.destroy(): "Destroy OK" else: "Destroy failed"

proc button1Clicked(fun: WxClosure, parent: WxWindow, evn: pointer) =
  if cast[int](evn) == 0:
    return

  echo "Clicker Fun: ", fun.repr
  echo "Clicker Event: ", evn.repr
  echo "Clicker Data: ", parent.repr

  # This will show a no/yes modal dialog
  #let parent = cast[WxWindow](data)
  let msgDlg = wxMessageDialog(
    parent,
    "Do you really want to quit?", 
    "You pushed the button!",
    wxYES_NO or wxNO_DEFAULT)

  if msgDlg.showModal() == wxID_YES:
    echo "Ending..."
    ELJApp_ExitMainLoop() # this will end the mainloop

  # continue running

  # let ms: MxString = "Test"
  # Forcing a full GC run for debugging my MxString (not used right now)
  # GC_fullCollect()

  # cleaning up the dialog and exit
  msgDlg.delete

proc button2Clicked(fun: WxClosure, parent: WxWindow, evn: pointer) =
  if cast[int](evn) == 0:
    return

#  echo "Clicked '", fun.repr
#  echo "Clicker2 Event: ", evn.repr
#  echo "Clicker2 Data: ", parent.repr
  
  # just to have something going on we show the current scrolled window offset
  let scrolled = eljFindWindowById(myScrolledId, nil)
  var x, y: int

  wxScrolledWindow_GetViewStart(scrolled, addr x, addr y)
  #discard wxFrame_ShowFullScreen(mainFrame, true, 0)
  echo y

proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  # we need this so wxImage can load our wxBitmap from
  # the PNG file later!
  eljInitAllImageHandlers()

  let app = eljGetApp()

  #echo ELJApp_Initialized()
  let dispSize = eljDisplaySize()
  echo dispSize.w, " x ", dispSize.h

  let txt = eljGetUserName()
  
  echo "txt is: " & normalize(txt)

  let mainFrame = wxFrame(nil, wxID_ANY, "Hallo Nim World!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)

  # now using a "panel" instead of the raw frame.
  # This should look much better on windows (and older linux?)
  when true: # use panel
    let mainPanel = wxPanel(mainFrame, wxID_ANY)
    let mainSizer = wxBoxSizer(wxVERTICAL)
    mainSizer.addWindow(mainPanel,1, wxEXPAND)
    mainFrame.setSizer(mainSizer)  
  else:
    let mainPanel = mainFrame # try that to see the effect (on windows / linux)

  #mainFrame.setAutoLayout(true)

  let menuBar = wxMenuBar(0)
  let fileMenu = wxMenu("", 0)
  let fileNew = wxMenuItemEx(-1, "Neu", "", 0, nil)
  let fileOpen = wxMenuItemEx(-1, "Öffnen...") # skip defaults
  
  let fileNewId = fileNew.getId
  let fileOpenId = fileOpen.getId

  fileMenu.appendItem(fileNew)
  fileMenu.appendItem(fileOpen)
  discard menuBar.append(fileMenu, "File")
  wxFrame_SetMenuBar(mainFrame, menuBar)

  var cl_menu_new = wxClosure(myMenuNew, app)
  var cl_menu_open = wxClosure(myMenuOpen, app)
  discard menuBar.connect(fileNewId, fileNewId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_new)

  discard menuBar.connect(fileOpenId, fileOpenId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_open)

  # creating a vertical sizer
  let vsiz = wxBoxSizer(wxVERTICAL)

  # Add the sizer into the main window
  mainPanel.setSizer(vsiz)

  # creating a horizontal sizer for our buttons
  let hsiz = wxBoxSizer(wxHORIZONTAL)
 
  # add it to the vsizer
  vsiz.addSizer(hsiz, 0, wxEXPAND, 0, nil)

  # some "extra" size at the left of our buttons
  hsiz.add(wxSize(100,0), 1, wxEXPAND)

  # our Buttons
  let bt1 = makeButton(mainPanel,"Click Me 1", button1Clicked) # Button hinzufügen
  hsiz.addWindow(bt1, 0, wxALL , 10, nil)

  let bt2 = makeButton(mainPanel,"Click Me 2", button2Clicked) # Button hinzufügen
  hsiz.addWindow(bt2, 1, wxEXPAND or wxALL xor wxLEFT, 10, nil)

  let bt3 = makeButton(mainPanel,"Click Me 3", button2Clicked) # Button hinzufügen
  hsiz.addWindow(bt3, 0, wxALL xor wxLEFT, 10, nil)

  # make something more complex: a bitmap button
  
  # load an png image to a bitmap for usage as button
  let wxbmp = wxBitmapLoad("bitmap1.png", wxBITMAP_TYPE_PNG)
  
  # mache a borderless button (just the bitmap)
  let bt4 = wxBitmapButton(mainPanel, wxID_ANY, wxbmp, 0, 0, -1, -1, wxBORDER_NONE)
  hsiz.addWindow(bt4, 0, wxALL xor wxLEFT, 10, nil)

  # here i reuse the loaded bitmap for a button with border.
  # I guess thats wrong memorywise but not sure.
  let bt5 = wxBitmapButton(mainPanel, wxID_ANY, wxbmp, 0, 0, wxbmp.getWidth()+10, -1, 0)
  hsiz.addWindow(bt5, 0, wxALL xor wxLEFT, 10, nil)

  #vsiz.layout

  # add some text (right aligned for fun, does not work on ubuntu it seems)
  #let pst1 = wxPanel(mainPanel)
  let st1 = wxStaticText(mainPanel, wxID_ANY, "This is a static Text", 0, 0, -1, -1, wxALIGN_RIGHT)
 
  # highlight the background of the static text window
  let col1 = wxColourRGB(255,255,200)
  let col2 = wxColourRGB(255,220,200)
  #discard pst1.setBackgroundColour(col2)
  discard st1.setBackgroundColour(col1)

  vsiz.addWindow(st1, 0, wxALL or wxEXPAND, 10)

  # again some text right alighn but this time using a sizer
  let hp = wxBoxSizer(wxHORIZONTAL)
  let st2 = wxStaticText(mainPanel, wxID_ANY, "This is a static Text", 0, 0, -1, -1, wxALIGN_RIGHT)
    
  discard st2.setBackgroundColour(col2)

  hp.add(0, 0, 1, wxEXPAND, 0, nil)
  hp.addWindow(st2, 0, 0, 0, nil)
  vsiz.addSizer(hp, 0, wxLEFT or wxRIGHT or wxEXPAND, 10, nil)
 
  # The lable is not so static :)
  # following uses converters "magically"
  st2.setLabel("User: " & toUpper(eljGetUserName()))

  # memory leak testing (you need to free GetLabel)
  when false:
    for x in 0..1000:
      let tmp = st.getLabel
      #echo tmp
      #wxString_Delete tmp
      tmp.delete

    for x in 0..1000:
      let tmp: string = st.getLabel
      echo tmp

  # ListControl (some of the most important widgets for our case)

  let lcTable = mainPanel.wxListCtrl(wxID_ANY, wxPoint(0, 0), -1, 100, wxLC_REPORT)
  vsiz.addWindow(lcTable, 1, wxEXPAND or wxAll, 10, nil)
  var pos = 0
  pos = lcTable.insertColumn(0, "Vorname", 0, 100)
  pos = lcTable.insertColumn(pos+1, "Name", 0, 100)
  pos = lcTable.insertColumn(0, "Id", 0, 30) # insert 'in front'
  pos = lcTable.insertColumn(lcTable.getColumnCount(), "Alter", 0, 100)
  
  # A scrolling area!
  let scrolled = wxScrolledWindow(mainFrame, myScrolledId, 0, 0, -1, 100, wxSUNKEN_BORDER)
  
  let scsiz = wxBoxSizer(wxVERTICAL)
  let texts = ["The","Brown","Fox","jumps","over","the","lazy","dog"]

  for t in texts:
    let st = wxStaticText(scrolled, -1, t, 0, 0, -1, -1, 0)
    scsiz.addWindow(st, 0, wxEXPAND or wxALL, 0, nil)

  scrolled.setSizer(scsiz)
  #scrolled.setScrollbars(0, 10, 0, 0, 0, 0, false) # well
  scrolled.setScrollRate(0, 1) # this makes the scrollbars appear :)
  #scrolled.adjustScrollbars # ?
  #scrolled.enableScrolling(false,true) # stops scrolling but not the scrollbar movement
  #scrolled.showScrollbars(0,0) ??
  
  # on windows it will only scroll by mousewheel if it has the focus
  scrolled.setFocus() # focus scrolled on first display of the window
  
  vsiz.addWindow(scrolled, 0, wxEXPAND or wxAll, 10, nil)

  # Next a "wxGrid"

  let grid = wxGrid(mainFrame, myGridId, 0, 0, -1, -1, 0)

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
  let ged_ro = wxGridCellChoiceEditor_Ctor(ss.len, ss, false)
  grid.setCellEditor(0 , 1, ged_ro)

  # allows your own data too
  let ged_rw = wxGridCellChoiceEditor_Ctor(ss.len, ss, true)
  grid.setCellEditor(0 , 2, ged_rw)

  # the grid does only receive input on windows if not in a panel!?
  mainSizer.addWindow(grid, 0, wxEXPAND or wxAll, 0, nil)

  when false:
    # playing around .. using array as argument
    let size_array: array = [100,150]
    # this constrains the windows min size
    mainFrame.setMinSize(size_array)

  when false:
    # playing around .. using tuple as argument
    var tuple_size: WxSizeObj = (800, 600)
    # this constrains the windows max size
    mainFrame.setMaxSize(tuple_size)

  # so you can't make the window smaller than the buttons sizer
  hsiz.setSizeHints(mainFrame)
  vsiz.setSizeHints(mainFrame)

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

  # after the mainframe is visible we can "scroll" with a proc
  scrolled.scroll(0, 10)
  
  echo "appMain finished"

  # not needed
  #ELJApp_MainLoop()
  #ELJApp_Exit()

when isMainModule:
  # Initialising and running "appMain"
  let cl = wxClosure(appMain, nil) # Create Closure for appMain()
  cl.initializeC(0, nil) # Das startet alles und geht in den Loop

  # ... Mainloop running here ...

  echo "Done"
