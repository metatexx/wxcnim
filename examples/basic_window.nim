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
  
  let parent = cast[WxWindow](data)
  let txt = newWxString "Do you really want to quit?"
  let cap = newWxString "You pushed the button!"
  let msgDlg = wxMessageDialog_Create(parent, txt, cap, wxYES_NO or wxNO_DEFAULT)
  if msgDlg.wxMessageDialog_ShowModal == wxID_YES:
    echo "Ending..."
    ELJApp_ExitMainLoop() # this will end the mainloop
  
  # cleaning up the dialog and exit
  msgDlg.wxMessageDialog_Delete


proc makeButton(parent: WxFrame): WxButton =
  let txt = newWxString "Push Me!"
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

  let txt = newWxString("Hallo Nim World!")

  let mainFrame = wxFrame_Create( nil, wxID_ANY, txt, -1, -1, -1, -1, wxDEFAULT_FRAME_STYLE)

  let menuBar = wxMenuBar_Create(0)
  let fileMenu = wxMenu_Create(newWxString(""), 0)
  let fileNew = wxMenuItem_CreateEx(-1, newWxString("Neu"), newWxString(""), 0, nil)
  
  let fileNewId = fileNew.wxMenuItem_GetId

  wxMenu_AppendItem(fileMenu, fileNew)
  discard wxMenuBar_Append(menuBar, fileMenu, newWxString("File"))
  wxFrame_SetMenuBar(mainFrame, menuBar)




  # Adding a panel to the Frame
  let panel1 = wxPanel_Create(mainFrame, wxID_ANY,  -1,-1,-1,-1, 0)
  let panel2 = wxPanel_Create(mainFrame, wxID_ANY,  -1,-1,-1,-1, 0)

  let sizer = wxBoxSizer_Create(wxVERTICAL)

  wxSizer_AddWindow(sizer, panel1, 0, wxEXPAND + wxALL, 10, nil)
  wxSizer_AddWindow(sizer, panel2, 0, wxEXPAND + wxAll, 10, nil)
  
  discard panel1.makeButton # Button hinzufügen

  wxWindow_SetSizer(mainFrame, sizer)

  # ListControl (some of the most important widgets for our case)
  let lcTable = wxListCtrl_Create(panel2, wxID_ANY, 0, 0, 200, 100, wxLC_REPORT)
  let thName = newWxString "Name"
  let thVorname = newWxString "Vorname"

  var pos: cint = 0
  pos = wxListCtrl_InsertColumn(lcTable, pos, thName, 0, 100)
  pos = wxListCtrl_InsertColumn(lcTable, pos, thVorname, 0, 100)

  var cl_menu_new = wxClosure_Create(myMenuSelected, app)
  discard wxEvtHandler_Connect(menuBar, fileNewId, fileNewId, expEVT_COMMAND_MENU_SELECTED(), cl_menu_new)

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
