# wxprocs include

# ELJApp


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

proc ELJApp_MainLoop*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetApp*(): WxApp
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Pending*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Initialized*(): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_DisplaySize*(): WxSize
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Dispatch*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Bell*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetUserName*(): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_InitAllImageHandlers*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetUserHome*(): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_FindWindowById*(id: int, prt: WxWindow): WxWindow
  {.cdecl, dynlib: WXCLibName, importc.}

# wxString

proc wxString_CreateUTF8*(buffer: cstring): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_Delete*(s: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_Length*(s: WxString): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxString_GetString*(s: WxString, b: pointer): int
  {.cdecl, dynlib: WXCLibName, importc.}

#proc wxClosure_Create*(fun: proc {.stdcall.} , data: pointer): WxClosure
#  {.cdecl, dynlib: WXCLibName, importc.}

proc wxClosure_Create*(fun: proc {.stdcall.} , data: WxClosureTypes): WxClosure
  {.cdecl, dynlib: WXCLibName, importc.}

# wxFrame

proc wxFrame_Create*(p: WxWindow, id: WxId, txt: WxString,
  x: int, y: int, w: int, h: int , stl: WxFrameStyle): WxFrame
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetMenuBar*(obj: WxFrame, menubar: WxMenuBar)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_ShowFullScreen*(obj: WxFrame, show: bool, style: int): bool
  {.cdecl, dynlib: WXCLibName, importc.}

# wxWindow

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

proc wxWindow_SetLabel*(obj: WxWindow, txt: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_GetLabel*(obj: WxWindow): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSizer*(obj: WxWindow, sizer: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSizeHints*(obj: WxWindow, minW, minH, maxW, maxH, incW, incH: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetBackgroundColour*(obj: WxWindow, colour: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTopLevelWindow

proc wxTopLevelWindow_SetMaxSize*(obj: WxWindow, w,h: int)
  {.cdecl, dynlib: WXCLibName, importc.}


proc wxTopLevelWindow_SetMinSize*(obj: WxWindow, w,h: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTopLevelWindow_Maximize*(obj: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxScrolledWindow

proc wxScrolledWindow_Create*(prt: WxWindow, id: int, lft, top, wdt, hgt: int, stl: int): WxScrolledWindow
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_AdjustScrollbars*(obj: WxScrolledWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_EnableScrolling*(obj: WxScrolledWindow, scrollh, scrollv: bool)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_ShowScrollbars*(obj: WxScrolledWindow, showh, showv: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_SetScrollRate*(obj: WxScrolledWindow, rateh, ratev: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_SetScrollbars*(obj: WxScrolledWindow, pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, xPos, yPos: int, noRefresh:bool )
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_Scroll*(obj: WxScrolledWindow, x_pos, y_pos: int)
  {.cdecl, dynlib: WXCLibName, importc.}
  
proc wxScrolledWindow_GetViewStart*(obj: WxScrolledWindow, x: ptr int, y: ptr int)
  {.cdecl, dynlib: WXCLibName, importc.}


# wxMenu

proc wxMenu_Create*(title: WxString, style: clong ): WxMenu
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenu_AppendItem*(obj: WxMenu, itm: WxMenuItem)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenu_GetLabelText*(obj: WxWindow): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

# wxMenuBar

proc wxMenuBar_Create*(style: int): WxMenuBar
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuBar_Append*(onj: WxMenuBar, menu: WxMenu, title: WxString): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxMenuItem

proc wxMenuItem_Create*(): WxMenuItem
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMenuItem_CreateEx*(id: int, label: WxString, help: WxString,
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

proc wxMenuItem_GetLabelText*(obj: WxWindow): WxString
  {.cdecl, dynlib: WXCLibName, importc.}


#    void       wxMenuItem_SetSubMenu( TSelf(wxMenuItem) _obj, TClass(wxMenu) menu );

proc wxMenuItem_SetItemLabel*(obj: WxMenuItem, str: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxButton

proc wxButton_Create*(prt: WxWindow, id: WxId, txt: WxString, lft: int, top: int, wdt: int, hgt: int, stl: int): WxButton
  {.cdecl, dynlib: WXCLibName, importc.}

# wxColour

proc wxColour_CreateRGB*(red, green, blue, alpha: int = 255): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBitmap

proc wxBitmap_CreateLoad*(name: WxString, kind: WxBitmapType): WxBitmap
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_Delete*(obj: WxBitmap)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_GetHeight*(obj: WxBitmap): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_GetWidth*(obj: WxBitmap): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBitmapButton

proc wxBitmapButton_Create*(prt: WxWindow, id: int, bmp: WxBitmap, lft, top, wdt, hgt: int, stl: int): WxBitmapButton
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBoxSizer

#TClass(wxSize) wxBoxSizer_CalcMin( TSelf(wxBoxSizer) _obj );
proc wxBoxSizer_Create*(orient: WxOrientation): WxBoxSizer
  {.cdecl, dynlib: WXCLibName, importc.}
#int        wxBoxSizer_GetOrientation( TSelf(wxBoxSizer) _obj );
#void       wxBoxSizer_RecalcSizes( TSelf(wxBoxSizer) _obj );

# wxSizer (abstract)

proc wxSizer_Add*(obj: WxSizer, width, height, option, flag, border: int, userData: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_AddWindow*(obj: WxSizer, window: WxWindow, option: int, flag: int, border: int, userData: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_AddSizer*(obj: WxSizer, sizer: WxSizer, option, flag, border: int, userData: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_Layout*(obj: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_SetSizeHints*(obj: WxSizer, wnd: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

#TClass(wxSize) wxSizer_CalcMin( TSelf(wxSizer) _obj );

# wxControl

proc wxControl_SetLabel*(obj: WxControl, txt: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxStaticText

proc wxStaticText_Create*(prt: WxWindow, id: WxId, txt: WxString, lft: cint, top: cint,
  wdt: cint, hgt: cint, stl: WxStaticTextStyle): WxStaticText
  {.cdecl, dynlib: WXCLibName, importc.}

# wxListCtrl

proc wxListCtrl_Create*(prt: WxWindow, id: WxId, lft: cint, top: cint, wdt: cint, hgt: cint, stl: WxLCStyle): WxListCtrl
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxListCtrl_InsertColumn*(obj: WxListCtrl, col: cint, heading: WxString, format: cint, width: cint): cint
  {.cdecl, dynlib: WXCLibName, importc.}


# wxEvtHandler

proc wxEvtHandler_Connect*(obj: pointer, first: WxId, last: WxId, kind: cint, data: WxClosure): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxPanel_Create*(prt: WxWindow , id: WxId, lft, top, wdt, hgt: int, stl: int): WxPanel
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_Create*(prt: WxWindow, msg: WxString, cap: WxString, spc: WxDialogSpecs): WxMessageDialog
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_Delete*(obj: WxMessageDialog)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_ShowModal*(obj: WxMessageDialog): WxId
  {.cdecl, dynlib: WXCLibName, importc.}

# (c) Hans Raaf - METATEXX GmbH
