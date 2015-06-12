import macros

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc wxPoint*(x, y: cint): cint = discard
proc wxSize*(w, h: cint): cint = discard

proc wxColor*(r, g, b: cint): cint = discard
proc wxRect*(a, b, c, d: cint): cint = discard

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
    echo s
    result = parseStmt(s)


wxcUnpacking(wxClosure, wxClosure_Create)
wxcUnpacking(wxListCtrl, wxListCtrl_Create)
wxcUnpacking(wxBoxSizer, wxBoxSizer_Create)
wxcUnpacking(wxStaticText, wxStaticText_Create)
wxcUnpacking(wxMenuBar, wxMenuBar_Create)
wxcUnpacking(wxMenu, wxMenu_Create)
wxcUnpacking(wxMenuItem, wxMenuItem_Create)
wxcUnpacking(wxMenuItemEx, wxMenuItem_CreateEx)

wxcUnpacking(insertColumn, wxListCtrl_InsertColumn)

wxcUnpacking(add, wxSizer_AddWindow)

wxcUnpacking(setSizer, wxWindow_SetSizer)
wxcUnpacking(show, wxWindow_Show)
wxcUnpacking(fit, wxWindow_Fit)
wxcUnpacking(raize, wxWindow_Raise) # raize vs raise!

wxcUnpacking(setLabel, wxControl_SetLabel)

wxcUnpacking(appendItem, wxMenu_AppendItem)
wxcUnpacking(append, wxMenu_Append)

wxcUnpacking(getId, wxMenuItem_GetId)


# menubar
wxcUnpacking(connect, wxEvtHandler_Connect)

