import macros

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc wxPoint*(x, y: int): int = discard
proc wxSize*(w, h: int): int = discard

proc wxColor*(r, g, b: int): int = discard
proc wxRect*(a, b, c, d: int): int = discard

template wxcUnpacking(nimname,extname) =
  macro nimname*(n: varargs[untyped]): untyped =
    var s: string = astToStr(extname) & "("
    var first = true
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

      elif x.kind == nnkSym and ((x.getType).typeKind) in { ntyTuple, ntyArray }:
        for y in 0 .. x.getType().len()-2:
          add(s, ", ")
          add(s, repr(x) & "[" & $y & "]")
        continue

      if unpack:
        for i in 1..<x.len:
          if first: 
            first = false
          else:
            add(s, ", ")
          add(s, repr(x[i]))
      else:
        if first: 
          first = false
        else:
          add(s, ", ")
        add(s, repr(x))
      
    add(s, ")")
    #echo s
    result = parseStmt(s)

# This works like a method call for the as "what" given type
template wxcUnpackingT(what,nimname,extname) =
    macro nimname*(p: what, n: varargs[untyped]): untyped =
      var s: string = astToStr(extname) & "(" & repr(p)
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
        elif x.kind == nnkSym and ((x.getType).typeKind) in { ntyTuple, ntyArray }:
          for y in 0 .. x.getType().len()-2:
            add(s, ", ")
            add(s, repr(x) & "[" & $y & "]")
          continue

        if unpack:
          for i in 1..<x.len:
            add(s, ", ")
            add(s, repr(x[i]))
        else:
          add(s, ", ")
          add(s, repr(x))
        
      add(s, ")")
      #echo s
      result = parseStmt(s)

# App wrapper
wxcUnpacking(eljGetApp, ELJApp_GetApp)
wxcUnpacking(eljDisplaySize, ELJApp_DisplaySize)
wxcUnpacking(eljGetUserName, ELJApp_GetUserName)
wxcUnpacking(eljInitAllImageHandlers, ELJApp_InitAllImageHandlers)

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

wxcUnpackingT(WxWindow, setSizer, wxWindow_SetSizer)
wxcUnpackingT(WxWindow, setBackgroundColour, wxWindow_SetBackgroundColour)

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
wxcUnpacking(insertColumn, wxListCtrl_InsertColumn)

# Static Widgets
wxcUnpacking(wxStaticText, wxStaticText_Create)

# Requester
wxcUnpacking(wxMessageDialog, wxMessageDialog_Create)

# Menu(bar) related
wxcUnpacking(wxMenuBar, wxMenuBar_Create)
wxcUnpacking(wxMenu, wxMenu_Create)
wxcUnpacking(wxMenuItem, wxMenuItem_Create)
wxcUnpacking(wxMenuItemEx, wxMenuItem_CreateEx)

wxcUnpacking(appendItem, wxMenu_AppendItem)
wxcUnpacking(append, wxMenuBar_Append)

wxcUnpacking(getId, wxMenuItem_GetId)
