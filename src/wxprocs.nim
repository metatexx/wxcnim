# wxprocs include

# ELJApp
when isMainModule:
  include wxlibname
  include wxdefs
  include wxtypes

proc ELJApp_InitializeC*(closure: WxClosure, argc: int, argv: pointer )
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_Exit*()
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_ExitMainLoop*()
  {.cdecl, dynlib: WXCLibName, importc.}

#proc ELJApp_initialize*(vptr1: pointer, vptr2: pointer, argc: cint, argv: pointer)
#  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_SetTopWindow*( wnd: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_GetTopWindow*(): WxWindow
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

proc ELJApp_GetUserHome*(user: WxString): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc ELJApp_FindWindowById*(id: WxId, prt: WxWindow = nil): WxWindow
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

proc wxClosure_Create*(fun: proc (fun, data, evt: pointer) {.cdecl.},
                       data: pointer): WxClosure
  {.cdecl, dynlib: WXCLibName, importc.}

# wxFrame
proc wxFrame_Create*(p: WxWindow = nil, id: WxId = WxId(wxID_ANY),
  title: WxString = wxString_CreateUTF8("Default Frame Title"),
  x: int = -1, y: int = -1, w: int = -1, h: int = -1,
  stl: WxFrameStyle = wxDEFAULT_FRAME_STYLE): WxFrame
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetMenuBar*(obj: WxFrame, menubar: WxMenuBar)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_ShowFullScreen*(obj: WxFrame, show: bool, style: int): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_CreateStatusBar*(obj: WxFrame, number: int = 1,
  style: WxSTBStyle = wxSTB_DEFAULT_STYLE): WxStatusBar
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_GetStatusBar*(obj: WxFrame): WxStatusBar
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetStatusBar*(obj: WxFrame, status: WxStatusBar)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetStatusText*(obj: WxFrame, text: WxString, num: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxStatusBar_SetStatusText*(obj: WxStatusBar, text: WxString, num: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFrame_SetStatusWidths*(obj: WxStatusBar, num: int, widths: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}


# wxWindow

proc wxWindow_Raise*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Show*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Hide*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Close*(p: WxWindow, force: bool = false)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Fit*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_FitInside*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Layout*(p: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetLabel*(obj: WxWindow, txt: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_GetLabel*(obj: WxWindow): WxString
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSizer*(obj: WxWindow, sizer: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSizeHints*(obj: WxWindow, minW, minH, maxW, maxH, incW, incH: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetSize*(obj: WxWindow, lft, top, wdt, hgt: int, sizeFlags: WxSizeFlags = wxSIZE_AUTO)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetBackgroundColour*(obj: WxWindow, colour: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetAutoLayout*(obj: WxWindow, autolayout: bool)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_SetFocus*(obj: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Refresh*(obj: WxWindow, eraseBackground: bool = true)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxWindow_Destroy*(obj: WxWindow): bool
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTopLevelWindow

proc wxTopLevelWindow_SetMaxSize*(obj: WxWindow, w,h: int)
  {.cdecl, dynlib: WXCLibName, importc.}


proc wxTopLevelWindow_SetMinSize*(obj: WxWindow, w,h: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTopLevelWindow_Maximize*(obj: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTopLevelWindow_SetIcon*(obj: WxWindow, icon: WxIcon)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxIcon

proc wxIcon_CreateDefault*(): WxIcon
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxIcon_CopyFromBitmap*(obj: WxIcon, bmp: WxBitmap)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxIcon_CreateLoad*(name: WxString,
  kind: WxBitmapType = wxBITMAP_TYPE_XBM,
  wdt: int = -1, hgt: int = -1): WxIcon
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxIcon_FromXPM*(data: pointer): WxIcon
  {.cdecl, dynlib: WXCLibName, importc.}

# wxPanel

proc wxPanel_Create*(prt: WxWindow, id: WxId = -1,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: WxBorder = 0): WxPanel
  {.cdecl, dynlib: WXCLibName, importc.}

# wxDC

proc wxDC_SetPen*(obj: WxDC, pen: WxPen)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_SetBrush*(obj: WxDC, pen: WxBrush)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_SetFont*(obj: WxDC, font: WxFont)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_DrawCircle*(obj: WxDC, x,y : int, radius: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_DrawLine*(obj: WxDC, x1,y1, x2,y2 : int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_DrawRectangle*(obj: WxDC, lft,top, wdt,hgt : int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_DrawText*(obj: WxDC, text: WxString, lft,top: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_GetTextExtent*(obj: WxDC, text: WxString,
  w, h, descent, externalLeading: pointer, theFont: WxFont)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_GetTextBackground*(obj: WxDC, colour: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_GetTextForeground*(obj: WxDC, colour: pointer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_SetTextBackground*(obj: WxDC, colour: WxColour)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_SetTextForeground*(obj: WxDC, colour: WxColour)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_IsOk*(obj: WxDC): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxDC_Clear*(obj: WxDC)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxClientDC

proc wxClientDC_Create*(win: WxWindow): WxClientDC
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxClientDC_Delete*(obj: WxClientDC)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxPaintDC

proc wxPaintDC_Create*(win: WxWindow): WxPaintDC
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxPaintDC_Delete*(obj: WxPaintDC)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxPen

proc wxPen_CreateFromColour*(col: WxColour, width: int, style: WxPenStyle): WxPen
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxPen_CreateFromStock*(id: int): WxPen
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxPen_Delete*(pen: WxPen)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBrush

proc wxBrush_CreateFromColour*(col: WxColour, style: WxBrushStyle): WxBrush
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBrush_CreateFromStock*(id: int): WxBrush
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBrush_Delete*(brush: WxBrush)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxFont

proc wxFont_CreateDefault*(): WxFont
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFont_SetPointSize*(obj: WxFont, pointSize: int)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxScrolledWindow

proc wxScrolledWindow_Create*(prt: WxWindow, id: int,
  lft, top, wdt, hgt: int, stl: WxBorder): WxScrolledWindow
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_AdjustScrollbars*(obj: WxScrolledWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_EnableScrolling*(obj: WxScrolledWindow, scrollh, scrollv: bool)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_ShowScrollbars*(obj: WxScrolledWindow, showh, showv: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_SetScrollRate*(obj: WxScrolledWindow, rateh, ratev: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_SetScrollbars*(obj: WxScrolledWindow,
  pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY,
  xPos, yPos: int, noRefresh:bool )
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_Scroll*(obj: WxScrolledWindow, x_pos, y_pos: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxScrolledWindow_GetViewStart*(obj: WxScrolledWindow, x: ptr int, y: ptr int)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxNotebook
proc wxNotebook_Create*(prt: WxWindow, id: int,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: WxNotebookStyle = 0): WxNotebook
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxNotebook_AddPage*(obj: WxNotebook, pPage: WxWindow, label: WxString, select: bool, imageID: int=0): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxNotebook_SetSelection*(obj: WxNotebook, nPage: int): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBookCtrlEvent

proc wxBookCtrlEvent_GetSelection*(evn: WxBookCtrlEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBookCtrlEvent_GetOldSelection*(evn: WxBookCtrlEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxGrid

proc wxGrid_Create*(prt: WxWindow, id: int,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: int = 0): WxGrid
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_CreateGrid*(obj: WxGrid, rows: int, cols: int, selmode: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_BeginBatch*(obj: WxGrid)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_EndBatch*(obj: WxGrid)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_DisableDragColSize*(obj: WxGrid)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_DisableDragRowSize*(obj: WxGrid)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_SetCellEditor*(obj: WxGrid, row: int, col: int,
  editor: WxGridCellEditor)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_SetReadOnly*(obj: WxGrid, row: int, col: int, readOnly: bool)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_SetCellValue*(obj: WxGrid, row: int, col: int, value: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxGrid_SetCellTextColour*(obj: WxGrid, row: int, col: int, value: WxColour)
  {.cdecl, dynlib: WXCLibName, importc.}

#

proc wxGridCellChoiceEditor_Ctor*( count: int ,
  choices: WxcArrayWideStrings, alllowOthers = true): WxGridCellChoiceEditor
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

proc wxMenuItem_CreateEx*(id: int,
  label: WxString = wxString_CreateUTF8("Does this work?"),
  help: WxString = wxString_CreateUTF8(""),
  itemkind: int = 0, submenu: WxMenu = nil): WxMenuItem
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


# void wxMenuItem_SetSubMenu( TSelf(wxMenuItem) _obj, TClass(wxMenu) menu );

proc wxMenuItem_SetItemLabel*(obj: WxMenuItem, str: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxButton

proc wxButton_Create*(prt: WxWindow, id: WxId, txt: WxString,
  left: int = -1, top: int = -1, width: int = -1, heigth: int = -1,
  style: int64 = 0): WxButton
  {.cdecl, dynlib: WXCLibName, importc.}

# wxColour

proc wxColour_CreateRGB*(red, green, blue, alpha: int = 255): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_CreateByName*(name: WxString): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_CreateEmpty*(): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_CreateFromStock*(id: int): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Delete*(col: WxColour)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Set*(col: WxColour, red, green, blue, alpha: int = 255)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_SetByName*(col: WxColour, name: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_ValidName*(name: WxString): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Copy*(col: WxColour): WxColour
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Alpha*(col: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Red*(col: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Green*(col: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxColour_Blue*(col: WxColour): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBitmap

proc wxBitmap_CreateLoad*(name: WxString, kind: WxBitmapType): WxBitmap
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_CreateFromXPM*(data: pointer): WxBitmap
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_Delete*(obj: WxBitmap)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_GetHeight*(obj: WxBitmap): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxBitmap_GetWidth*(obj: WxBitmap): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBitmapButton

proc wxBitmapButton_Create*(prt: WxWindow, id: int, bmp: WxBitmap,
  lft, top, wdt, hgt: int, stl: WxBorder): WxBitmapButton
  {.cdecl, dynlib: WXCLibName, importc.}

# wxBoxSizer

#TClass(wxSize) wxBoxSizer_CalcMin( TSelf(wxBoxSizer) _obj );
proc wxBoxSizer_Create*(orient: WxOrientation = wxVERTICAL): WxBoxSizer
  {.cdecl, dynlib: WXCLibName, importc.}
#int        wxBoxSizer_GetOrientation( TSelf(wxBoxSizer) _obj );
#void       wxBoxSizer_RecalcSizes( TSelf(wxBoxSizer) _obj );

# wxSizer (abstract)

proc wxSizer_Add*(obj: WxSizer, width: int = 0, heigth: int = 0, opt: int = 0,
  flags: WxStretch = 0, border: int = 0, udt: pointer = nil)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_AddWindow*(obj: WxSizer, wnd: WxWindow, opt: int = 0,
  flg: WxStretch = 0, brd: int = 0, udt: pointer = nil)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_AddSizer*(obj: WxSizer, sizer: WxSizer, opt: int = 0,
  flg: WxStretch = 0, brd: int = 0, udt: pointer = nil)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_Layout*(obj: WxSizer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxSizer_SetSizeHints*(obj: WxSizer, wnd: WxWindow)
  {.cdecl, dynlib: WXCLibName, importc.}

#TClass(wxSize) wxSizer_CalcMin( TSelf(wxSizer) _obj );

# wxStaticBox

proc wxStaticBox_Create*(prt: WxWindow, id: WxId, label: WxString,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: int = 0): WxStaticBox
  {.cdecl, dynlib: WXCLibName, importc.}

# wxStaticBoxSizer

proc wxStaticBoxSizer_Create*(box: WxStaticBox,
  orient: WxOrientation = wxVERTICAL): WxBoxSizer
  {.cdecl, dynlib: WXCLibName, importc.}

# wxControl

proc wxControl_SetLabel*(obj: WxControl, txt: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxStaticText

proc wxStaticText_Create*(prt: WxWindow, id: WxId, txt: WxString,
  lft: cint, top: cint, wdt: cint, hgt: cint,
  stl: WxStaticTextStyle): WxStaticText
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTextCtrl

proc wxTextCtrl_Create*(prt: WxWindow, id: WxId, text: WxString, left: int = -1, top: int = -1, width: int = -1, height: int = -1, style: WxTextCtrlStyle = 0): WxTextCtrl
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTextCtrl_AppendText*(obj: WxTextCtrl, text: WxString)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxListCtrl

proc wxListCtrl_Create*(prt: WxWindow, id: WxId,
  lft: int, top: int, wdt: int, hgt: int, stl: WxLCStyle): WxListCtrl
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxListCtrl_InsertColumn*(obj: WxListCtrl, col: int,
  heading: WxString, format: int, width: int): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxListCtrl_GetColumnCount*(obj: WxListCtrl): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxCheckListBox

proc wxCheckListBox_Create*(prt: WxWindow, id: WxId,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  n: int, str: WxcArrayWideStrings, style: int64 ) : WxCheckListBox
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxCheckListBox_Delete*(obj: WxCheckListBox)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxCheckListBox_IsChecked*(obj: WxCheckListBox, item: int): bool
  {.cdecl, dynlib: WXCLibName, importc.}

# wxEvtHandler

proc wxEvtHandler_Connect*(obj: WxWindow, first: WxId = -1, last: WxId = -1,
  kind: int, data: WxClosure): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxEvent

proc wxEvent_GetEventType*(obj: WxEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxEvent_GetEventObject*(obj: WxEvent): WxWindow
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxEvent_GetId*(obj: WxEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxEvent_GetTimestamp*(obj: WxEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxEvent_SetId*(obj: WxEvent, id: int)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxEvent_Skip*(obj: WxEvent)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxNotifyEvent

proc wxNotifyEvent_Veto*(obj: WxNotifyEvent)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxKeyEvent

proc wxKeyEvent_GetKeyCode*(obj: WxKeyEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxKeyEvent_GetModifiers*(obj: WxKeyEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxKeyEvent_GetX*(obj: WxKeyEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxKeyEvent_GetY*(obj: WxKeyEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxMouseEvent

proc wxMouseEvent_GetX*(obj: WxMouseEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMouseEvent_GetY*(obj: WxMouseEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxMenuEvent

proc wxMenuEvent_GetMenuId*(obj: WxMenuEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTimer

proc wxTimer_Create*(prt: WxWindow, id: WxId): WxTimer
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_Delete*(obj: WxTimer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_Start*(obj: WxTimer, millisecs: int = 1000,
  oneshot: bool = false): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_Stop*(obj: WxTimer)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_GetInterval*(evn: WxTimer): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_IsOneShot*(evn: WxTimer): bool
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimer_IsRuning*(evn: WxTimer): bool
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTimerEx

proc wxTimerEx_Create*(): WxTimerEx
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxTimerEx_Connect*(timer: WxTimerEx, cl: WxClosure)
  {.cdecl, dynlib: WXCLibName, importc.}

# wxTimerEvent

proc wxTimerEvent_GetInterval*(evn: WxTimerEvent): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxDialog

proc wxDialog_ShowModal*(obj: WxDialog): int
  {.cdecl, dynlib: WXCLibName, importc.}

# wxMessageDialog

proc wxMessageDialog_Create*(prt: WxWindow, msg: WxString, cap: WxString,
  spc: WxDialogSpecs): WxMessageDialog
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_Delete*(obj: WxMessageDialog)
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxMessageDialog_ShowModal*(obj: WxMessageDialog): WxId
  {.cdecl, dynlib: WXCLibName, importc.}

# wxFileDialog

proc wxFileDialog_Create*(prt: WxWindow, msg: WxString, dir: WxString,
  fle: WxString, wcd: WxString,
  lft: int = 0, top: int = 0,
  stl: WxFileDialogStyle = wxFD_DEFAULT_STYLE): WxFileDialog
  {.cdecl, dynlib: WXCLibName, importc.}

proc wxFileDialog_GetPath*(obj: WxFileDialog): WxString
  {.cdecl, dynlib: WXCLibName, importc.}


# (c) Hans Raaf - METATEXX GmbH
