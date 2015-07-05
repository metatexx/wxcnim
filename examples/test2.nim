import macros

type WxButton = ptr object

proc wxButton_Create*(prt: pointer, id: int, txt: string, lft: int = 0, top: int = 0, wdt: int = 0, hgt: int = 0, stl: int = 0): WxButton =
  result = nil

template wxcUnpacking(nimname,extname) =
  macro wxButton(x: varargs[untyped]): untyped =
    echo repr(x)
    for c in x.children:
      #echo repr(c)
      if c.kind in nnkCallKinds:
        case $c[0]:
        of "foo": echo "foo!"
        else: discard
    
    result = parseStmt("wxButton_Create(nil, 0, \"test\", 0,0, -1,-1, 0)")

wxcUnpacking(wxButton, wxButton_Create)

proc makeButton(a: string): WxButton =
  result = wxButton(nil, 0, a, 0,0, -1, stl=2)

let x: WxButton = makeButton("Test")
echo repr(x)
