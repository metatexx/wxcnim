import macros

# we need these dummy constructors due to the wrong implementation
# of 'varargs[untyped]' in the compiler:

proc mxPos*(x, y: cint): cint = discard
proc mxPoint*(x, y: cint): cint = discard
proc mxColor*(r, g, b: cint): cint = discard
proc mxRect*(a, b, c, d: cint): cint = discard

template wxcUnpacking(nimname,extname) =
  macro nimname*(n: varargs[untyped]): untyped =
    var s: string = astToStr(extname) & "("
    var first = true
    for x in n.children:
      var unpack = false
      if x.kind in nnkCallKinds:
        case $x[0]
        of "mxPoint":
          expectLen(x, 3)
          unpack = true
        of "mxPos":
          expectLen(x, 3)
          unpack = true
        of "mxRect":
          expectLen(x, 5)
          unpack = true
        of "mxColor":
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

wxcUnpacking(listCtrl, wxListCtrl_Create)
wxcUnpacking(add, wxSizer_AddWindow)
wxcUnpacking(insertColumn, wxListCtrl_InsertColumn)
