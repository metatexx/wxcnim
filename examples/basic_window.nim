# Simples wxWidgets Beispiel
# Benutzt using wxc

import wxcnim
import strutils

#import mxstring (not needed atm)

proc myMenuSelected(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return
  echo "Menu Event: ", evn.repr
  echo "Menu Data: ", data.repr
  # bell (wau wau)
  ELJApp_Bell()

proc myButtonClicked(fun: pointer, parent: WxWindow, evn: pointer) =
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


proc makeButton(parent: WxFrame): WxButton =
  result = wxButton(parent, -1, "Push Me!", 0, 0, -1, -1, 0)
  var cl = wxClosure(myButtonClicked, parent)
  echo "cl: ", myButtonClicked.repr
  discard result.connect(-1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)


proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  #ELJApp_InitAllImageHandlers() # probably not needed

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

  # creating a virutal sizer as container
  let sizer = wxBoxSizer(wxVERTICAL)
  
  # our Button
  let bt = makeButton(mainFrame) # Button hinzufügen
  sizer.add(bt, 0, wxEXPAND + wxALL, 10, nil)

  # add some text (right aligned for fun)
  let st = wxStaticText(mainFrame, -1, "This is a static Text", 0, 0, -1, -1, wxST_ALIGN_RIGHT)
  sizer.add(st, 0, wxEXPAND + wxALL, 10, nil)

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
  sizer.add(lcTable, 0, wxEXPAND or wxAll, 10, nil)
  discard lcTable.insertColumn(-1, "Vorname", 0, 100)
  discard lcTable.insertColumn(-1, "Name", 0, 100)
  discard lcTable.insertColumn(0, "Id", 0, 30) # insert 'in front'
  discard lcTable.insertColumn(-1, "Alter", 0, 100)
  
  #wxSizer_Layout(sizer)
  
  # Add the sizer into the main window
  mainFrame.setSizer(sizer)

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
