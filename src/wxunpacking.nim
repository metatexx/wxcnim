import macros

# make it compilable and therefor testable
when isMainModule:
  import wxtypes

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc wxPoint*(x, y: int) = discard
proc wxSize*(w, h: int) = discard

proc wxColor*(r, g, b: int) = discard
proc wxRect*(a, b, c, d: int) = discard


template wxcUnpacking(nimname,extname) =
  macro nimname*(n: varargs[untyped]): expr =
    var call = newCall(!astToStr(extname))
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

# This works like a method call for the as "what" given type
template wxcUnpackingT(what,nimname,extname) =
    macro nimname*(p: what, n: varargs[untyped]): expr =
      var call = newCall(!astToStr(extname))
      call.add(p)
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


# App wrapper
wxcUnpacking(eljGetApp, ELJApp_GetApp)
wxcUnpacking(eljBell, ELJApp_Bell)
wxcUnpacking(eljDisplaySize, ELJApp_DisplaySize)
wxcUnpackingT(WxId, eljFindWindowById, ELJApp_FindWindowById)
wxcUnpacking(eljGetUserName, ELJApp_GetUserName)
wxcUnpacking(eljGetUserHome, ELJApp_GetUserHome)
wxcUnpacking(eljInitAllImageHandlers, ELJApp_InitAllImageHandlers)
wxcUnpacking(eljExitMainLoop, ELJApp_ExitMainLoop)

# wxEvent

wxcUnpackingT(WxEvent, getEventType, wxEvent_GetEventType)
wxcUnpackingT(WxEvent, getEventObject, wxEvent_GetEventObject)
wxcUnpackingT(WxEvent, getId, wxEvent_GetId)
wxcUnpackingT(WxEvent, getTimestamp, wxEvent_GetTimestamp)
wxcUnpackingT(WxEvent, skip, wxEvent_Skip)
wxcUnpackingT(WxEvent, setId, wxEvent_SetId)

# wxKeyEvent
wxcUnpackingT(WxKeyEvent, getKeyCode, wxKeyEvent_GetKeyCode)

# wxString
wxcUnpackingT(WxString, delete, wxString_Delete)

# wxBitmap
wxcUnpacking(wxBitmapLoad, wxBitmap_CreateLoad)

wxcUnpackingT(WxBitmap, delete, wxBitmap_Delete)
wxcUnpackingT(WxBitmap, getHeight, wxBitmap_GetHeight)
wxcUnpackingT(WxBitmap, getWidth, wxBitmap_GetWidth)

# wxBitmapButton
wxcUnpacking(wxBitmapButton, wxBitmapButton_Create)

# wxColour
wxcUnpacking(wxColourRGB, wxColour_CreateRGB)

# Events + Closure (Glue)
wxcUnpacking(wxClosure, wxClosure_Create)

wxcUnpackingT(WxClosure, initializeC, ELJApp_InitializeC)

wxcUnpacking(connect, wxEvtHandler_Connect)

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
wxcUnpackingT(WxWindow, fit, wxWindow_Fit)
wxcUnpackingT(WxWindow, raize, wxWindow_Raise) # raize vs raise!
wxcUnpackingT(WxWindow, `raise`, wxWindow_Raise)
wxcUnpackingT(WxWindow, destroy, wxWindow_Destroy)

wxcUnpackingT(WxWindow, setSizer, wxWindow_SetSizer)
wxcUnpackingT(WxWindow, setBackgroundColour, wxWindow_SetBackgroundColour)

wxcUnpackingT(WxWindow, setFocus, wxWindow_SetFocus)
wxcUnpackingT(WxWindow, setAutoLayout, wxWindow_SetAutoLayout)

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

# WxFrame
wxcUnpacking(wxFrame, wxFrame_Create)

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
wxcUnpackingT(WxTimerEx, connect, wxTimerEx_Connect)

# wxTimerEvent

wxcUnpackingT(WxTimerEvent, getInterval, wxTimerEvent_GetInterval)

when isMainModule:
  proc wxButton_Create(a: WxWindow, b:WxId, c:string, d:int, e:int, f:int, g:int, h:int): WxButton =
    #echo locals()
    return nil
  
  let a = wxButton(nil, 0, "test", 0,0, -1,-1, 0)
  echo a.repr()
