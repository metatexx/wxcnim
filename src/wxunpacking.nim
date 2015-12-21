import macros

# make it compilable and therefor testable
when isMainModule:
  import wxtypes
  import wxprocs

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc wxPoint*(x, y: int) = discard
proc wxSize*(w, h: int) = discard

proc wxColor*(r, g, b: int) = discard
proc wxRect*(a, b, c, d: int) = discard

proc unpackHelper(n: NimNode, extname: string, what: NimNode): NimNode =
  var call = newCall(!extname)
  if not what.isNil: call.add(what)
  for x in n.children:
    var unpack = false
    if x.kind in nnkCallKinds:
      case $x[0]
      of "wxPoint":
        expectLen(x, 3)
        unpack = true
      of "wxSize":
        expectLen(x, 3)
        unpack = true
      of "wxRect":
        expectLen(x, 5)
        unpack = true
      of "wxColor":
        expectLen(x, 4)
        unpack = true
      else: discard

    if unpack:
      for i in 1..<x.len:
        call.add(x[i])
    else:
      call.add(x)
  result = newStmtList(call)

template wxcUnpacking(nimname,extname) =
  macro nimname*(n: varargs[untyped]): expr =
    unpackHelper(n, astToStr(extname), nil)

# This works like a method call for the as "what" given type
template wxcUnpackingT(what,nimname,extname) =
  macro nimname*(p: what, n: varargs[untyped]): expr =
    unpackHelper(n, astToStr(extname), p)

# App wrapper
wxcUnpacking(wxnGetApp, ELJApp_GetApp)
wxcUnpacking(wxnBell, ELJApp_Bell)
wxcUnpacking(wxnDisplaySize, ELJApp_DisplaySize)
wxcUnpackingT(WxId, wxnFindWindowById, ELJApp_FindWindowById)
wxcUnpacking(wxnGetUserName, ELJApp_GetUserName)
wxcUnpacking(wxnGetUserHome, ELJApp_GetUserHome)
wxcUnpacking(wxnInitAllImageHandlers, ELJApp_InitAllImageHandlers)
wxcUnpacking(wxnExitMainLoop, ELJApp_ExitMainLoop)
wxcUnpacking(wxnInitialized, ELJApp_Initialized)

# wxEvent

wxcUnpackingT(WxEvent, getEventType, wxEvent_GetEventType)
wxcUnpackingT(WxEvent, getEventObject, wxEvent_GetEventObject)
wxcUnpackingT(WxEvent, getId, wxEvent_GetId)
wxcUnpackingT(WxEvent, getTimestamp, wxEvent_GetTimestamp)
wxcUnpackingT(WxEvent, skip, wxEvent_Skip)
wxcUnpackingT(WxEvent, setId, wxEvent_SetId)

# wxKeyEvent
wxcUnpackingT(WxKeyEvent, getKeyCode, wxKeyEvent_GetKeyCode)
wxcUnpackingT(WxKeyEvent, getX, wxKeyEvent_GetX)
wxcUnpackingT(WxKeyEvent, getY, wxKeyEvent_GetY)

# wxMouseEvent
wxcUnpackingT(WxMouseEvent, getX, wxMouseEvent_GetX)
wxcUnpackingT(WxMouseEvent, getY, wxMouseEvent_GetY)


# wxString
wxcUnpackingT(WxString, delete, wxString_Delete)

# wxBitmap
wxcUnpacking(wxBitmapLoad, wxBitmap_CreateLoad)
wxcUnpacking(wxBitmapFromXPM, wxBitmap_Create_FromXPM)

wxcUnpackingT(WxBitmap, delete, wxBitmap_Delete)
wxcUnpackingT(WxBitmap, getHeight, wxBitmap_GetHeight)
wxcUnpackingT(WxBitmap, getWidth, wxBitmap_GetWidth)

# wxBitmapButton
wxcUnpacking(wxBitmapButton, wxBitmapButton_Create)

# wxIcon
wxcUnpacking(wxIconFromXPM, wxIcon_Create_FromXPM)

# wxColour
wxcUnpacking(wxColourRGB, wxColour_CreateRGB)

wxcUnpacking(wxColourByName, wxColour_CreateByName)

# Events + Closure (Glue)
wxcUnpacking(wxClosure, wxClosure_Create)

wxcUnpackingT(WxClosure, initializeC, ELJApp_InitializeC)

#wxcUnpacking(connect, wxEvtHandler_Connect)

# Sizers
wxcUnpacking(wxBoxSizer, wxBoxSizer_Create)

wxcUnpackingT(WxSizer, add, wxSizer_Add)
wxcUnpackingT(WxSizer, addWindow, wxSizer_AddWindow)
wxcUnpackingT(WxSizer, addSizer, wxSizer_AddSizer)

wxcUnpackingT(WxSizer, layout, wxSizer_Layout)
wxcUnpackingT(WxSizer, setSizeHints, wxSizer_SetSizeHints)

# WxWindow
wxcUnpackingT(WxWindow, getLabel, wxWindow_GetLabel)
wxcUnpackingT(WxWindow, show, wxWindow_Show)
wxcUnpackingT(WxWindow, hide, wxWindow_Hide)
wxcUnpackingT(WxWindow, setSize, wxWindow_SetSize)
wxcUnpackingT(WxWindow, fit, wxWindow_Fit)
wxcUnpackingT(WxWindow, raize, wxWindow_Raise) # raize vs raise!
wxcUnpackingT(WxWindow, `raise`, wxWindow_Raise)
wxcUnpackingT(WxWindow, destroy, wxWindow_Destroy)

wxcUnpackingT(WxWindow, setSizer, wxWindow_SetSizer)
wxcUnpackingT(WxWindow, setBackgroundColour, wxWindow_SetBackgroundColour)

wxcUnpackingT(WxWindow, setFocus, wxWindow_SetFocus)
wxcUnpackingT(WxWindow, setAutoLayout, wxWindow_SetAutoLayout)

wxcUnpackingT(WxWindow, refresh, wxWindow_Refresh)

# WxTopLevelWindow

wxcUnpackingT(WxWindow, setMinSize, wxTopLevelWindow_SetMinSize)
wxcUnpackingT(WxWindow, setMaxSize, wxTopLevelWindow_SetMaxSize)

# WxScrolledWindow

wxcUnpacking(wxScrolledWindow, wxScrolledWindow_Create)

wxcUnpackingT(WxScrolledWindow, adjustScrollbars, wxScrolledWindow_AdjustScrollbars)
wxcUnpackingT(WxScrolledWindow, enableScrolling, wxScrolledWindow_EnableScrolling)
wxcUnpackingT(WxScrolledWindow, showScrollbars, wxScrolledWindow_ShowScrollbars)
wxcUnpackingT(WxScrolledWindow, setScrollbars, wxScrolledWindow_SetScrollbars)
wxcUnpackingT(WxScrolledWindow, setScrollRate, wxScrolledWindow_SetScrollRate)
wxcUnpackingT(WxScrolledWindow, scroll, wxScrolledWindow_Scroll)
wxcUnpackingT(WxScrolledWindow, getViewStart, wxScrolledWindow_GetViewStart)

# WxClientDC

wxcUnpacking(wxClientDC, wxClientDC_Create)
wxcUnpackingT(WxClientDC, delete, wxClientDC_Delete)

# WxPaintDC

wxcUnpacking(wxPaintDC, wxPaintDC_Create)
wxcUnpackingT(WxPaintDC, delete, wxPaintDC_Delete)

# WxDC
wxcUnpackingT(WxDC, setPen, wxDC_SetPen)
wxcUnpackingT(WxDC, setBrush, wxDC_SetBrush)
wxcUnpackingT(WxDC, drawCircle, wxDC_DrawCircle)
wxcUnpackingT(WxDC, drawLine, wxDC_DrawLine)
wxcUnpackingT(WxDC, drawRectangle, wxDC_DrawRectangle)

proc getTextExtent*(obj: WxDC, text: WxString,
  theFont: WxFont = nil): WxTextExtent =
  result = (0,0,0,0)
  wxDC_GetTextExtent(obj, text, addr(result.w), addr(result.h),
    addr(result.descent), addr(result.externalLeading),
  theFont)

wxcUnpackingT(WxDC, setTextForeground, wxDC_SetTextForeground)
wxcUnpackingT(WxDC, setTextBackground, wxDC_SetTextBackground)

proc getTextForeground*(obj: WxDC): WxColour =
  result = wxColourRGB(0,0,0)
  wxDC_GetTextForeground(obj, result)

proc getTextBackground*(obj: WxDC): WxColour =
  result = wxColourRGB(0,0,0)
  wxDC_GetTextBackground(obj, result)

wxcUnpackingT(WxDC, drawText, wxDC_DrawText)
wxcUnpackingT(WxDC, isOk, wxDC_IsOk)
wxcUnpackingT(WxDC, clear, wxDC_Clear)

# WxGrid
wxcUnpacking(wxGrid, wxGrid_Create)
wxcUnpackingT(WxGrid, createGrid, wxGrid_CreateGrid)
wxcUnpackingT(WxGrid, beginBatch, wxGrid_BeginBatch)
wxcUnpackingT(WxGrid, endBatch, wxGrid_EndBatch)
wxcUnpackingT(WxGrid, disableDragRowSize, wxGrid_DisableDragRowSize)
wxcUnpackingT(WxGrid, disableDragColSize, wxGrid_DisableDragColSize)
wxcUnpackingT(WxGrid, setCellEditor, wxGrid_SetCellEditor)
wxcUnpackingT(WxGrid, setReadOnly, wxGrid_SetReadOnly)
wxcUnpackingT(WxGrid, setCellValue, wxGrid_SetCellValue)
wxcUnpackingT(WxGrid, setCellTextColour, wxGrid_SetCellTextColour)

# wxGridCellChoiceEditor
wxcUnpacking(wxGridCellChoiceEditor, wxGridCellChoiceEditor_Ctor)

# WxFrame
wxcUnpacking(wxFrame, wxFrame_Create)
wxcUnpackingT(WxFrame, setMenuBar, wxFrame_SetMenuBar)

# WxPanel
wxcUnpacking(wxPanel, wxPanel_Create)

# Controls: General
wxcUnpacking(setLabel, wxControl_SetLabel)

# Controls: Button
wxcUnpacking(wxButton, wxButton_Create)

# Controls: List Ctrl
wxcUnpacking(wxListCtrl, wxListCtrl_Create)

wxcUnpackingT(WxListCtrl, insertColumn, wxListCtrl_InsertColumn)
wxcUnpackingT(WxListCtrl, getColumnCount, wxListCtrl_GetColumnCount)

# Static Widgets
wxcUnpacking(wxStaticText, wxStaticText_Create)

# Requester
wxcUnpackingT(WxDialog, showModal, wxDialog_ShowModal)

wxcUnpacking(wxMessageDialog, wxMessageDialog_Create)
wxcUnpackingT(WxMessageDialog, showModal, wxMessageDialog_ShowModal)
wxcUnpackingT(WxMessageDialog, delete, wxMessageDialog_delete)

wxcUnpacking(wxFileDialog, wxFileDialog_Create)
wxcUnpackingT(WxFileDialog, getPath, wxFileDialog_GetPath)

# Menu(bar) related
wxcUnpacking(wxMenuBar, wxMenuBar_Create)
wxcUnpacking(wxMenu, wxMenu_Create)
wxcUnpacking(wxMenuItem, wxMenuItem_Create)
wxcUnpacking(wxMenuItemEx, wxMenuItem_CreateEx)

wxcUnpackingT(WxMenu, appendItem, wxMenu_AppendItem)
wxcUnpackingT(WxMenuBar, append, wxMenuBar_Append)

wxcUnpackingT(WxMenuItem, getId, wxMenuItem_GetId)

# wxTimer

wxcUnpacking(wxTimer, wxTimer_Create)
wxcUnpackingT(WxTimer, delete, wxTimer_Delete)
wxcUnpackingT(WxTimer, start, wxTimer_Start)
wxcUnpackingT(WxTimer, stop, wxTimer_Stop)
wxcUnpackingT(WxTimer, getInterval, wxTimer_GetInterval)
wxcUnpackingT(WxTimer, isOneShot, wxTimer_IsOneShot)
wxcUnpackingT(WxTimer, isRuning, wxTimer_IsRuning)

# wxTimerEx

wxcUnpacking(wxTimerEx, wxTimerEx_Create)
#wxcUnpackingT(WxTimerEx, connect, wxTimerEx_Connect)

# wxTimerEvent

wxcUnpackingT(WxTimerEvent, getInterval, wxTimerEvent_GetInterval)

when isMainModule:
  let a = wxButton(nil, 0, "test", 0,0, -1,-1, 0)
  echo a.repr()
