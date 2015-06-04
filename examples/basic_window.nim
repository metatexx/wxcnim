# Simples wxWidgets Beispiel
# Benutzt using wxc

import wxcnim

proc myMenuSelected(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return
  echo "Menu Event: ", evn.repr
  echo "Menu Data: ", data.repr
  # bell (wau wau)
  ELJApp_Bell()

proc myButtonClicked(fun, data, evn: pointer) =
  if cast[int](evn) == 0:
    return

  echo "Clicker Event: ", evn.repr
  echo "Clicker Data: ", data.repr
  
  # This will show a no/yes modal dialog
  let parent = cast[WxWindow](data)
  let txt = newMxString "Do you really want to quit?"
  let cap = newMxString "You pushed the button!"
  let msgDlg = wxMessageDialog_Create(parent, txt, cap, wxYES_NO or wxNO_DEFAULT)
  if msgDlg.wxMessageDialog_ShowModal == wxID_YES:
    echo "Ending..."
    ELJApp_ExitMainLoop() # this will end the mainloop

  # continue running

  # Forcing a full GC run for debugging my MxString implementation
  GC_fullCollect()
  
  # cleaning up the dialog and exit
  msgDlg.wxMessageDialog_Delete


proc makeButton(parent: WxFrame): WxButton =
  let txt = newMxString "Push Me!"
  result = wxButton_Create(parent, -1, txt, 0, 0, -1, -1, 0)
  var cl = wxClosure_Create(myButtonClicked, parent)
  discard wxEvtHandler_Connect(result, -1, -1, expEVT_COMMAND_BUTTON_CLICKED(), cl)

proc appMain(argc: pointer, argv: openArray[cstring]) =
  # argc und argv do not make sense to me :(

  #ELJApp_InitAllImageHandlers() # probably not needed

  let app = ELJApp_GetApp()

  #echo ELJApp_Initialized()
  let dispSize = ELJApp_DisplaySize()
  echo dispSize.w, " x ", dispSize.h

  #let txt = ELJApp_GetUserName()
  #echo "txt is: ", wxString_Length txt
  #wxString_Delete(txt)

  let mainFrame = wxFrame_Create( nil, wxID_ANY, "Hallo Nim World!", -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)

  let menuBar = wxMenuBar_Create(0)
  let fileMenu = wxMenu_Create(newMxString(""), 0)
  let fileNew = wxMenuItem_CreateEx(-1, newMxString("Neu"), newMxString(""), 0, nil)
  
  let fileNewId = fileNew.wxMenuItem_GetId

  wxMenu_AppendItem(fileMenu, fileNew)
  discard wxMenuBar_Append(menuBar, fileMenu, newMxString("File"))
  wxFrame_SetMenuBar(mainFrame, menuBar)

  var cl_menu_new = wxClosure_Create(myMenuSelected, app)
  discard wxEvtHandler_Connect(menuBar, fileNewId, fileNewId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_new)

  # creating a virutal sizer as container
  let sizer = wxBoxSizer_Create(wxVERTICAL)
  # and adding it into the main window
  wxWindow_SetSizer(mainFrame, sizer)

  # next we create some panels and add them to the sizer

  # this contains the button
  let panel1 = wxPanel_Create(mainFrame, wxID_ANY,  -1,-1,-1,-1, 0)
  discard panel1.makeButton # Button hinzufügen
  wxSizer_AddWindow(sizer, panel1, 0, wxEXPAND + wxALL, 10, nil)

  # this contains the ListControl
  let panel2 = wxPanel_Create(mainFrame, wxID_ANY,  -1,-1,-1,-1, 0)
  wxSizer_AddWindow(sizer, panel2, 0, wxEXPAND + wxAll, 10, nil)

  # ListControl (some of the most important widgets for our case)
  let lcTable = wxListCtrl_Create(panel2, wxID_ANY, 0, 0, 200, 100, wxLC_REPORT)
  let thVorname = newMxString "Vorname"
  let thName = newMxString "Name"

  var pos: cint = 0
  discard wxListCtrl_InsertColumn(lcTable, 1, thVorname, 0, 100)
  discard wxListCtrl_InsertColumn(lcTable, 0, thName, 0, 100)
  
  echo "pos: ", pos

  # this contains the GridStringTable
  let panel3 = wxPanel_Create(mainFrame, wxID_ANY,  -1,-1,-1,-1, 0)
  wxSizer_AddWindow(sizer, panel3, 0, wxEXPAND + wxAll, 10, nil)
  

  #wxSizer_Layout(sizer)

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
