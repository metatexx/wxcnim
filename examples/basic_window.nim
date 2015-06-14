# Simples wxWidgets Beispiel
# Benutzt using wxc

import wxcnim
import strutils
import os

const ScolledId = 1 

#import mxstring (not needed atm)

proc myMenuSelected(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return
  echo "Menu Event: ", evn.repr
  echo "Menu Data: ", data.repr
  # bell (wau wau)
  ELJApp_Bell()

proc button1Clicked(fun: pointer, parent: WxWindow, evn: pointer) =
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

  if msgDlg.wxMessageDialog_ShowModal == wxID_YES:
    echo "Ending..."
    ELJApp_ExitMainLoop() # this will end the mainloop

  # continue running

  # let ms: MxString = "Test"
  # Forcing a full GC run for debugging my MxString (not used right now)
  # GC_fullCollect()

  # cleaning up the dialog and exit
  msgDlg.wxMessageDialog_Delete

proc button2Clicked(fun: WxClosure, parent: WxWindow, evn: pointer) =
  if cast[int](evn) == 0:
    return

#  echo "Clicked '", fun.repr
#  echo "Clicker2 Event: ", evn.repr
#  echo "Clicker2 Data: ", parent.repr
  
  # just to have something going on we show the current scrolled window offset
  let scrolled = ELJApp_FindWindowById(ScolledId, nil)
  var x, y: int

  wxScrolledWindow_GetViewStart(scrolled, addr x, addr y)
  #discard wxFrame_ShowFullScreen(mainFrame, true, 0)
  echo y



proc makeButton(parent: WxFrame, text: string, cb: proc): WxButton =
  result = wxButton(parent, wxID_ANY, text, 0, 0, -1, -1, 0)
  var cl = wxClosure(cb, parent)
  #echo "cl: ", result.repr
  discard result.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)


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

  let menuBar = wxMenuBar(0)
  let fileMenu = wxMenu("", 0)
  let fileNew = wxMenuItemEx(-1, "Neu", "", 0, nil)
  
  let fileNewId = fileNew.getId

  fileMenu.appendItem(fileNew)
  discard menuBar.append(fileMenu, "File")
  wxFrame_SetMenuBar(mainFrame, menuBar)

  var cl_menu_new = wxClosure(myMenuSelected, app)
  discard menuBar.connect(fileNewId, fileNewId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_new)

  # creating a vertical sizer
  let vsiz = wxBoxSizer(wxVERTICAL)

  # creating a horizontal sizer
  let hsiz = wxBoxSizer(wxHORIZONTAL)
 
  # some "extra" size at the left
  hsiz.add(wxSize(100,0), 1, wxEXPAND, 0, nil)
    
  # our Buttons
  let bt1 = makeButton(mainFrame,"Click Me 1", button1Clicked) # Button hinzufügen
  hsiz.addWindow(bt1, 0, wxALL , 10, nil)

  let bt2 = makeButton(mainFrame,"Click Me 2", button2Clicked) # Button hinzufügen
  hsiz.addWindow(bt2, 1, wxEXPAND or wxALL xor wxLEFT, 10, nil)

  let bt3 = makeButton(mainFrame,"Click Me 3", button2Clicked) # Button hinzufügen
  hsiz.addWindow(bt3, 0, wxALL xor wxLEFT, 10, nil)

  # make something more complex: a bitmap button
  
  # load an png image to a bitmap for usage as button
  let wxbmp = wxBitmapLoad("bitmap1.png", wxBITMAP_TYPE_PNG)
  
  # mache a borderless button (just the bitmap)
  let bt4 = wxBitmapButton(mainFrame, wxID_ANY, wxbmp, 0, 0, -1, -1, wxBORDER_NONE)
  hsiz.addWindow(bt4, 0, wxALL xor wxLEFT, 10, nil)

  # here i reuse the loaded bitmap for a button with border.
  # I guess thats wrong memorywise but not sure.
  let bt5 = wxBitmapButton(mainFrame, wxID_ANY, wxbmp, 0, 0, wxbmp.getWidth()+10, -1, 0)
  hsiz.addWindow(bt5, 0, wxALL xor wxLEFT, 10, nil)

  hsiz.layout
 
  vsiz.addSizer(hsiz, 0, wxEXPAND, 0, nil)

  # add some text (right aligned for fun)
  let st = wxStaticText(mainFrame, wxID_ANY, "This is a static Text", 0, 0, -1, -1, wxST_ALIGN_RIGHT)
  vsiz.addWindow(st, 0, wxEXPAND + wxALL, 10, nil)

  # The lable is not so static :)
  # following uses converters "magically"
  st.setLabel("User: " & toUpper(eljGetUserName()))

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

  let lcTable = mainFrame.wxListCtrl(wxID_ANY, wxPoint(0, 0), -1, 100, wxLC_REPORT)
  vsiz.addWindow(lcTable, 1, wxEXPAND or wxAll, 10, nil)
  discard lcTable.insertColumn(-1, "Vorname", 0, 100)
  discard lcTable.insertColumn(-1, "Name", 0, 100)
  discard lcTable.insertColumn(0, "Id", 0, 30) # insert 'in front'
  discard lcTable.insertColumn(-1, "Alter", 0, 100)
  
  # A scrolling panel!
  let scrolled = wxScrolledWindow(mainFrame, ScolledId, 0, 0, -1, 100, wxSUNKEN_BORDER)
  
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
  
 
  vsiz.addWindow(scrolled, 0, wxEXPAND or wxAll, 10, nil)

  # so you can't make the window smaller than the buttons sizer
  hsiz.setSizeHints(mainFrame)
  #vsiz.setSizeHints(mainFrame)

  # Add the sizer into the main window
  mainFrame.setSizer(vsiz)

  when false:
    # playing around .. using array as argument
    let size_array: array = [100,150]
    # this constrains the windows min size
    mainFrame.setMinSize(size_array)

  # playing around .. using tuple as argument
  var tuple_size: WxSizeObj = (800, 600)
  # this constrains the windows max size
  mainFrame.setMaxSize(tuple_size)

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
