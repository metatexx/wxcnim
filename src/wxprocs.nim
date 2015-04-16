# wxprocs include

proc wxString_CreateUTF8*(buffer: cstring): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_Delete*(s: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_Length*(s: WxString): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_GetString*(s: WxString, b: pointer): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxClosure_Create*(fun: proc {.stdcall.} , data: pointer): WxClosure
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_InitializeC*(closure: WxClosure, argc: cint, argv: pointer )
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Exit*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_ExitMainLoop*()
  {.cdecl, dynlib: WXCLibName, importc.}

#proc ELJApp_initialize*(vptr1: pointer, vptr2: pointer, argc: cint, argv: pointer)
#  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_SetTopWindow*( wnd: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_MainLoop*(): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetApp*(): WxApp
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Pending*(): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Initialized*(): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_DisplaySize*(): WxSize
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Dispatch*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_Create*(p: WxWindow, id: WxId, txt: WxString,
  x: cint, y: cint, w: cint, h: cint , stl: WxFrameStyle): WxFrame
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetMenuBar*(obj: WxFrame, menubar: WxMenuBar)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Raise*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Show*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Hide*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Fit*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_FitInside*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSizer*(obj: WxWindow, sizer: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenu_Create*(title: WxString, style: clong ): WxMenu
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenu_AppendItem*(obj: WxMenu, itm: WxMenuItem)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuBar_Create*(style: cint): WxMenuBar
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuBar_Append*(onj: WxMenuBar, menu: WxMenu, title: WxString): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_Create*(): WxMenuItem
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_CreateEx*(id: cint, label: WxString, help: WxString,
  itemkind: int, submenu: WxMenu): WxMenuItem
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_SetCheckable*(obj: WxMenuItem, checkable: bool)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_SetHelp*(obj: WxMenuItem, str: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_SetId*(obj: WxMenuItem, id: WxId)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_GetId*(obj: WxMenuItem): WxId
  {.cdecl, dynlib: WXCLibName, importc.}

#    void       wxMenuItem_SetSubMenu( TSelf(wxMenuItem) _obj, TClass(wxMenu) menu );

proc wxMenuItem_SetItemLabel*(obj: WxMenuItem, str: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Bell*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetUserName*(): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_InitAllImageHandlers*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetUserHome*(): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxButton_Create*(prt: WxWindow, id: WxId, txt: WxString, lft: cint, top: cint, wdt: cint, hgt: cint, stl: cint): WxButton
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBoxSizer

#TClass(wxSize) wxBoxSizer_CalcMin( TSelf(wxBoxSizer) _obj );
proc wxBoxSizer_Create*(orient: WxOrientation): WxBoxSizer
  {.cdecl, dynlib: WXCLibName, importc.}
#int        wxBoxSizer_GetOrientation( TSelf(wxBoxSizer) _obj );
#void       wxBoxSizer_RecalcSizes( TSelf(wxBoxSizer) _obj );

# wxSizer (abstract)

proc wxSizer_AddWindow*(obj: WxSizer, window: WxWindow, option: int64, flag: int64, border: int64, userData: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_Layout*(obj: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

#TClass(wxSize) wxSizer_CalcMin( TSelf(wxSizer) _obj );

# wxListCtrl

proc wxListCtrl_Create*(prt: WxWindow, id: WxId, lft: cint, top: cint, wdt: cint, hgt: cint, stl: WxLCStyle): WxListCtrl
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxListCtrl_InsertColumn*(obj: WxListCtrl, col: cint, heading: WxString, format: cint, width: cint): cint
  {.cdecl, dynlib: WXCLibName, importc.}


# wxEvtHandler

proc wxEvtHandler_Connect*(obj: pointer, first: WxId, last: WxId, kind: cint, data: WxClosure): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxPanel_Create*(prt: WxWindow , id: WxId, lft: cint, top: cint, wdt: cint, hgt: cint, stl: cint): WxPanel
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_Create*(prt: WxWindow, msg: WxString, cap: WxString, spc: WxDialogSpecs): WxMessageDialog
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_Delete*(obj: WxMessageDialog)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_ShowModal*(obj: WxMessageDialog): WxId
  {.cdecl, dynlib: WXCLibName, importc.}

# (c) Hans Raaf - METATEXX GmbH
