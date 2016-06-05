import macros

# make it compilable and therefor testable
when isMainModule:
  import wxdefs
  import wxtypes
  import wxprocs

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc wxnPoint*(x, y: int) = discard
proc wxnSize*(w, h: int) = discard
proc wxnRect*(a, b, c, d: int) = discard

proc unpackHelper(n: NimNode, extname: string, what: NimNode): NimNode =
  var call = newCall(!extname)
  if not what.isNil: call.add(what)
  for x in n.children:
    var unpack = false
    if x.kind in nnkCallKinds:
      if x[0].kind == nnkIdent:
        case $x[0].ident
        of "wxnPoint":
          expectLen(x, 3)
          unpack = true
        of "wxnSize":
          expectLen(x, 3)
          unpack = true
        of "wxnRect":
          expectLen(x, 5)
          unpack = true
  #      of "wxColor":
  #        expectLen(x, 4)
  #        unpack = true
        else: discard

    if unpack:
      for i in 1..<x.len:
        call.add(x[i])
    else:
      call.add(x)
  result = newStmtList(call)

template wxnUnpacking(nimname,extname) =
  macro nimname*(n: varargs[untyped]): expr =
    unpackHelper(n, astToStr(extname), nil)

# This works like a method call for the as "what" given type
template wxnUnpackingT(what,nimname,extname) =
  macro nimname*(p: what, n: varargs[untyped]): expr =
    unpackHelper(n, astToStr(extname), p)

# App wrapper
wxnUnpacking(wxnGetApp, ELJApp_GetApp)
wxnUnpacking(wxnGetTopWindow, ELJApp_GetTopWindow)
wxnUnpacking(wxnSetTopWindow, ELJApp_SetTopWindow)
wxnUnpacking(wxnBell, ELJApp_Bell)
wxnUnpacking(wxnDisplaySize, ELJApp_DisplaySize)
wxnUnpackingT(WxId, wxnFindWindowById, ELJApp_FindWindowById)
wxnUnpacking(wxnGetUserName, ELJApp_GetUserName)
wxnUnpacking(wxnGetUserHome, ELJApp_GetUserHome)
wxnUnpacking(wxnInitAllImageHandlers, ELJApp_InitAllImageHandlers)
wxnUnpacking(wxnExitMainLoop, ELJApp_ExitMainLoop)
wxnUnpacking(wxnInitialized, ELJApp_Initialized)

# wxEvent

wxnUnpackingT(WxEvent, getEventType, wxEvent_GetEventType)
wxnUnpackingT(WxEvent, getEventObject, wxEvent_GetEventObject)
wxnUnpackingT(WxEvent, getId, wxEvent_GetId)
wxnUnpackingT(WxEvent, getTimestamp, wxEvent_GetTimestamp)
wxnUnpackingT(WxEvent, skip, wxEvent_Skip)
wxnUnpackingT(WxEvent, setId, wxEvent_SetId)

# wxNotifyEvent

wxnUnpackingT(WxNotifyEvent, veto, wxNotifyEvent_Veto)
wxnUnpackingT(WxNotifyEvent, allow, wxNotifyEvent_Allow)

# wxKeyEvent
wxnUnpackingT(WxKeyEvent, getKeyCode, wxKeyEvent_GetKeyCode)
wxnUnpackingT(WxKeyEvent, getModifiers, wxKeyEvent_GetModifiers)
wxnUnpackingT(WxKeyEvent, getX, wxKeyEvent_GetX)
wxnUnpackingT(WxKeyEvent, getY, wxKeyEvent_GetY)

# wxMouseEvent
wxnUnpackingT(WxMouseEvent, getX, wxMouseEvent_GetX)
wxnUnpackingT(WxMouseEvent, getY, wxMouseEvent_GetY)

# wxMenuEvent
wxnUnpackingT(WxMenuEvent, getMenuId, wxMenuEvent_GetMenuId)

# wxBookCtrlEvent
wxnUnpackingT(WxBookCtrlEvent, getSelection, wxBookCtrlEvent_GetSelection)
wxnUnpackingT(WxBookCtrlEvent, getOldSelection, wxBookCtrlEvent_GetOldSelection)

# wxString
wxnUnpackingT(WxString, delete, wxString_Delete)

# wxBitmap
wxnUnpacking(wxBitmapLoad, wxBitmap_CreateLoad)
wxnUnpacking(wxBitmapFromXPM, wxBitmap_Create_FromXPM)

wxnUnpackingT(WxBitmap, delete, wxBitmap_Delete)
wxnUnpackingT(WxBitmap, getHeight, wxBitmap_GetHeight)
wxnUnpackingT(WxBitmap, getWidth, wxBitmap_GetWidth)

# wxBitmapButton
wxnUnpacking(wxBitmapButton, wxBitmapButton_Create)

# wxIcon
wxnUnpacking(wxIconFromXPM, wxIcon_Create_FromXPM)

# wxColour
wxnUnpacking(wxColour, wxColour_CreateEmpty)
wxnUnpacking(wxColourRGB, wxColour_CreateRGB)
wxnUnpacking(wxColourByName, wxColour_CreateByName)
wxnUnpacking(wxColourFromStock, wxColour_CreateFromStock)

wxnUnpackingT(WxColour, copy, wxColour_Copy)

wxnUnpackingT(WxColour, delete, wxColour_Delete)
wxnUnpackingT(WxColour, alpha, wxColour_Alpha)
wxnUnpackingT(WxColour, red, wxColour_Red)
wxnUnpackingT(WxColour, green, wxColour_Green)
wxnUnpackingT(WxColour, blue, wxColour_Blue)

# Events + Closure (Glue)
wxnUnpacking(wxClosure, wxClosure_Create)

wxnUnpackingT(WxClosure, initializeC, ELJApp_InitializeC)

#wxnUnpacking(connect, wxEvtHandler_Connect)

# Sizers
wxnUnpacking(wxBoxSizer, wxBoxSizer_Create)

wxnUnpackingT(WxSizer, add, wxSizer_Add)
wxnUnpackingT(WxSizer, addWindow, wxSizer_AddWindow)
wxnUnpackingT(WxSizer, addSizer, wxSizer_AddSizer)

wxnUnpackingT(WxSizer, layout, wxSizer_Layout)
wxnUnpackingT(WxSizer, setSizeHints, wxSizer_SetSizeHints)

# WxWindow
wxnUnpackingT(WxWindow, getLabel, wxWindow_GetLabel)
wxnUnpackingT(WxWindow, show, wxWindow_Show)
wxnUnpackingT(WxWindow, hide, wxWindow_Hide)
wxnUnpackingT(WxWindow, close, wxWindow_Close)
wxnUnpackingT(WxWindow, setSize, wxWindow_SetSize)
wxnUnpackingT(WxWindow, fit, wxWindow_Fit)
wxnUnpackingT(WxWindow, raize, wxWindow_Raise) # raize vs raise!
wxnUnpackingT(WxWindow, `raise`, wxWindow_Raise)
wxnUnpackingT(WxWindow, destroy, wxWindow_Destroy)

wxnUnpackingT(WxWindow, setSizer, wxWindow_SetSizer)
wxnUnpackingT(WxWindow, setBackgroundColour, wxWindow_SetBackgroundColour)

wxnUnpackingT(WxWindow, setFocus, wxWindow_SetFocus)
wxnUnpackingT(WxWindow, setAutoLayout, wxWindow_SetAutoLayout)

wxnUnpackingT(WxWindow, refresh, wxWindow_Refresh)

# WxTopLevelWindow

wxnUnpackingT(WxWindow, setMinSize, wxTopLevelWindow_SetMinSize)
wxnUnpackingT(WxWindow, setMaxSize, wxTopLevelWindow_SetMaxSize)

# WxScrolledWindow

wxnUnpacking(wxScrolledWindow, wxScrolledWindow_Create)

wxnUnpackingT(WxScrolledWindow, adjustScrollbars, wxScrolledWindow_AdjustScrollbars)
wxnUnpackingT(WxScrolledWindow, enableScrolling, wxScrolledWindow_EnableScrolling)
wxnUnpackingT(WxScrolledWindow, showScrollbars, wxScrolledWindow_ShowScrollbars)
wxnUnpackingT(WxScrolledWindow, setScrollbars, wxScrolledWindow_SetScrollbars)
wxnUnpackingT(WxScrolledWindow, setScrollRate, wxScrolledWindow_SetScrollRate)
wxnUnpackingT(WxScrolledWindow, scroll, wxScrolledWindow_Scroll)
wxnUnpackingT(WxScrolledWindow, getViewStart, wxScrolledWindow_GetViewStart)

# WxClientDC

wxnUnpacking(wxClientDC, wxClientDC_Create)
wxnUnpackingT(WxClientDC, delete, wxClientDC_Delete)

# WxPaintDC

wxnUnpacking(wxPaintDC, wxPaintDC_Create)
wxnUnpackingT(WxPaintDC, delete, wxPaintDC_Delete)

# WxDC
wxnUnpackingT(WxDC, setPen, wxDC_SetPen)
wxnUnpackingT(WxDC, setBrush, wxDC_SetBrush)
wxnUnpackingT(WxDC, setFont, wxDC_SetFont)
wxnUnpackingT(WxDC, drawCircle, wxDC_DrawCircle)
wxnUnpackingT(WxDC, drawLine, wxDC_DrawLine)
wxnUnpackingT(WxDC, drawRectangle, wxDC_DrawRectangle)

wxnUnpackingT(WxDC, setTextForeground, wxDC_SetTextForeground)
wxnUnpackingT(WxDC, setTextBackground, wxDC_SetTextBackground)

wxnUnpackingT(WxDC, drawText, wxDC_DrawText)
wxnUnpackingT(WxDC, isOk, wxDC_IsOk)
wxnUnpackingT(WxDC, clear, wxDC_Clear)
wxnUnpackingT(WxDC, drawBitmap, wxDC_DrawBitmap)

# WxGrid
wxnUnpacking(wxGrid, wxGrid_Create)
wxnUnpackingT(WxGrid, createGrid, wxGrid_CreateGrid)
wxnUnpackingT(WxGrid, beginBatch, wxGrid_BeginBatch)
wxnUnpackingT(WxGrid, endBatch, wxGrid_EndBatch)
wxnUnpackingT(WxGrid, disableDragRowSize, wxGrid_DisableDragRowSize)
wxnUnpackingT(WxGrid, disableDragColSize, wxGrid_DisableDragColSize)
wxnUnpackingT(WxGrid, setCellEditor, wxGrid_SetCellEditor)
wxnUnpackingT(WxGrid, setReadOnly, wxGrid_SetReadOnly)
wxnUnpackingT(WxGrid, setCellValue, wxGrid_SetCellValue)
wxnUnpackingT(WxGrid, setCellTextColour, wxGrid_SetCellTextColour)

# wxGridCellChoiceEditor
wxnUnpacking(wxGridCellChoiceEditor, wxGridCellChoiceEditor_Ctor)

# WxFrame
wxnUnpacking(wxFrame, wxFrame_Create)
wxnUnpackingT(WxFrame, setMenuBar, wxFrame_SetMenuBar)

wxnUnpackingT(WxFrame, createStatusBar, wxFrame_CreateStatusBar)
wxnUnpackingT(WxFrame, getStatusBar, wxFrame_GetStatusBar)

# WxPanel
wxnUnpacking(wxPanel, wxPanel_Create)

# Controls: General
wxnUnpacking(setLabel, wxControl_SetLabel)

# Controls: Button
wxnUnpacking(wxButton, wxButton_Create)

# Controls: List Ctrl
wxnUnpacking(wxListCtrl, wxListCtrl_Create)

wxnUnpackingT(WxListCtrl, insertColumn, wxListCtrl_InsertColumn)
wxnUnpackingT(WxListCtrl, getColumnCount, wxListCtrl_GetColumnCount)

# Controls: CheckListBox
wxnUnpacking(wxCheckListBox, wxCheckListBox_Create)

wxnUnpackingT(WxCheckListBox, delete, wxCheckListBox_Delete)
wxnUnpackingT(WxCheckListBox, isChecked, wxCheckListBox_IsChecked)

# Controls: Text Ctrl
wxnUnpacking(wxTextCtrl, wxTextCtrl_Create)

wxnUnpackingT(WxTextCtrl, appendText, wxTextCtrl_AppendText)

# Static Widgets
wxnUnpacking(wxStaticText, wxStaticText_Create)

# wxStaticBox
wxnUnpacking(wxStaticBox, wxStaticBox_Create)

# wxStaticBoxSizer
wxnUnpacking(wxStaticBoxSizer, wxStaticBoxSizer_Create)

# WxNotebook
wxnUnpacking(wxNotebook, wxNotebook_Create)
wxnUnpackingT(WxNotebook, addPage, wxNotebook_AddPage)

# Requester
wxnUnpackingT(WxDialog, showModal, wxDialog_ShowModal)

wxnUnpacking(wxMessageDialog, wxMessageDialog_Create)
wxnUnpackingT(WxMessageDialog, showModal, wxMessageDialog_ShowModal)
wxnUnpackingT(WxMessageDialog, delete, wxMessageDialog_delete)

wxnUnpacking(wxFileDialog, wxFileDialog_Create)
wxnUnpackingT(WxFileDialog, getPath, wxFileDialog_GetPath)

# Menu(bar) related
wxnUnpacking(wxMenuBar, wxMenuBar_Create)
wxnUnpacking(wxMenu, wxMenu_Create)
wxnUnpacking(wxMenuItem, wxMenuItem_Create)
wxnUnpacking(wxMenuItemEx, wxMenuItem_CreateEx)

wxnUnpackingT(WxMenu, appendItem, wxMenu_AppendItem)
wxnUnpackingT(WxMenuBar, append, wxMenuBar_Append)

wxnUnpackingT(WxMenuItem, getId, wxMenuItem_GetId)

# StatusBar related
wxnUnpackingT(WxStatusBar, setStatusText, wxStatusBar_SetStatusText)

# wxTimer

wxnUnpacking(wxTimer, wxTimer_Create)
wxnUnpackingT(WxTimer, delete, wxTimer_Delete)
wxnUnpackingT(WxTimer, start, wxTimer_Start)
wxnUnpackingT(WxTimer, stop, wxTimer_Stop)
wxnUnpackingT(WxTimer, getInterval, wxTimer_GetInterval)
wxnUnpackingT(WxTimer, isOneShot, wxTimer_IsOneShot)
wxnUnpackingT(WxTimer, isRuning, wxTimer_IsRuning)

# wxTimerEx

wxnUnpacking(wxTimerEx, wxTimerEx_Create)
#wxnUnpackingT(WxTimerEx, connect, wxTimerEx_Connect)

# wxTimerEvent

wxnUnpackingT(WxTimerEvent, getInterval, wxTimerEvent_GetInterval)

# wxPen
wxnUnpackingT(WxPen, delete, wxPen_Delete)

# wxBrush
wxnUnpackingT(WxBrush, delete, wxBrush_Delete)

# wxFont
wxnUnpacking(wxDefaultFont, wxFont_CreateDefault)
wxnUnpackingT(WxFont, setPointSize, wxFont_SetPointSize)


when isMainModule:
  let a = wxButton(nil, 0, "test", 0,0, -1,-1, 0)
  echo a.repr()
