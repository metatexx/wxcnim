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
  let msgDlg = wxMessageDialog_Create(
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
  result = wxButton_Create(parent, -1, "Push Me!", 0, 0, -1, -1, 0)
  var cl = wxClosure_Create(myButtonClicked, parent)
  echo "cl: ", myButtonClicked.repr
  discard wxEvtHandler_Connect(result, -1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)


proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  #ELJApp_InitAllImageHandlers() # probably not needed

  let app = ELJApp_GetApp()

  #echo ELJApp_Initialized()
  let dispSize = ELJApp_DisplaySize()
  echo dispSize.w, " x ", dispSize.h

  let txt = ELJApp_GetUserName()
  echo "txt is: " & normalize(txt)

  let mainFrame = wxFrame_Create( nil, wxID_ANY, "Hallo Nim World!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)

  let menuBar = wxMenuBar_Create(0)
  let fileMenu = wxMenu_Create("", 0)
  let fileNew = wxMenuItem_CreateEx(-1, "Neu", "", 0, nil)
  
  let fileNewId = fileNew.wxMenuItem_GetId

  wxMenu_AppendItem(fileMenu, fileNew)
  discard wxMenuBar_Append(menuBar, fileMenu, "File")
  wxFrame_SetMenuBar(mainFrame, menuBar)

  var cl_menu_new = wxClosure_Create(myMenuSelected, app)
  discard wxEvtHandler_Connect(menuBar, fileNewId, fileNewId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_new)

  # creating a virutal sizer as container
  let sizer = wxBoxSizer_Create(wxVERTICAL)
  
  # and adding it into the main window
  wxWindow_SetSizer(mainFrame, sizer)
  
  # our Button
  let bt = makeButton(mainFrame) # Button hinzufügen
  wxSizer_AddWindow(sizer, bt, 0, wxEXPAND + wxALL, 10, nil)

  # add some text (right aligned for fun)
  let st = wxStaticText_Create(mainFrame, -1, "This is a static Text", 0, 0, -1, -1, wxST_ALIGN_RIGHT)
  wxSizer_AddWindow(sizer, st, 0, wxEXPAND + wxALL, 10, nil)

  # The lable is not so static :)
  # following uses converters "magically"
  wxControl_SetLabel(st, "User: " & toUpper(ELJApp_GetUserName()))

  # memory leak testing (you need to free GetLabel)
  when false:
    for x in 0..1000:
      let tmp = st.wxWindow_GetLabel
      #echo tmp
      #wxString_Delete tmp
      tmp.delete

    for x in 0..1000:
      let tmp: string = st.wxWindow_GetLabel
      echo tmp

  # ListControl (some of the most important widgets for our case)
  let lcTable = wxListCtrl_Create(mainFrame, wxID_ANY, 0, 0, -1, 100, wxLC_REPORT)
  wxSizer_AddWindow(sizer, lcTable, 0, wxEXPAND + wxAll, 10, nil)

  var pos: cint = 0
  pos = wxListCtrl_InsertColumn(lcTable, -1, "Vorname", 0, 100)
  echo "Vorname pos: ", pos
  pos = wxListCtrl_InsertColumn(lcTable, -1, "Name", 0, 100)
  echo "Name pos: ", pos
  pos = wxListCtrl_InsertColumn(lcTable, 0, "Id", 0, 30)
  echo "Id pos: ", pos
  pos = wxListCtrl_InsertColumn(lcTable, -1, "Alter", 0, 100)
  echo "Alter pos: ", pos
  
  #wxSizer_Layout(sizer)

  # this constrains the windows min size
  wxTopLevelWindow_SetMinSize(mainFrame, 100, 150)

  # this constrains the windows max size
  wxTopLevelWindow_SetMaxSize(mainFrame, 800, 600)
  
  wxWindow_Fit(mainFrame)
  
  wxWindow_Show mainFrame
  wxWindow_Raise mainFrame
  
  echo "appMain finished"

  # not needed
  #ELJApp_MainLoop()
  #ELJApp_Exit()

when isMainModule:
  # Initialising and running "appMain"
  let cl = wxClosure_Create(appMain, nil) # Create Closure for appMain()
  ELJApp_InitializeC(cl, 0, nil) # Das startet alles und geht in den Loop

  # ... Mainloop running here ...

  echo "Done"
