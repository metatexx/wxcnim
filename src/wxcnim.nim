## wxcnim - wxWidgets for Nim
##
## (c) Hans Raaf - METATEXX GmbH
##
## License MIT (see LICENSE.txt)

include wxlibname

import unicode

include wxtypes
include wxdefs
include wxprocs
include wxunpacking
include wxevents

converter toWxId*(x: WxStandardId): WxId = cast[WxId](x)

converter toWxClosureTypes*(x: WxApp): WxClosureTypes = cast[WxClosureTypes](x)
converter toWxClosureTypes*(x: WxWindow): WxClosureTypes = cast[WxClosureTypes](x)

converter toWxWindow*(x: WxDialog): WxWindow = cast[WxWindow](x)

# Create a UTF8 String from an WxString (does not consume the WxString)
proc `$`*(self: WxString): string =
  #echo "DBG: Create string from WxString called"
  if self.wxString_Length == 0:
    result = ""
  else:
    var s = newSeq[WxcWide](self.wxString_Length)
    discard wxString_GetString(self, addr s[0])
    result = ""
    for w in s:
      result.add Rune(w).toUTF8

# Creates a wide string
proc wxcWideString*(s: string): WxcWideStringShadow =
  result = newSeq[WxcWide](s.len+1)
  var i=0
  for r in runes(s):
    result[i]=WxcWide(r)
    i+=1
  result[i]=0

proc wxcArrayWideStrings*(a: openArray[string]): WxcArrayWideStringsShadow =
  result = new WxcArrayWideStringsShadowObj

  result.shadow = newSeq[WxcWideStringShadow](a.len)
  result.build = newSeq[ptr WxcWide](a.len)

  var i = 0
  for x in a:
    var ws = wxcWideString(x)
    result.shadow[i] = ws
    result.build[i] = addr(ws[0])
    inc i

  result.proxy = addr(result.build[0])

proc len*(o: WxcArrayWideStringsShadow): int = o.shadow.len()

converter toWxcArrayWideStrings*(s: WxcArrayWideStringsShadow): WxcArrayWideStrings = s.proxy

when isMainModule:
  var ss = wxcArrayWideStrings(["1test","2me","3bla"])
  echo ss[].proxy.repr

# Makes a new WxString from a "string"
converter toWxString*(s: string): WxString =
  #echo "DBG: string->WxString conversion for " & s
  result = wxString_CreateUTF8(s)

# Deleting a WxString
#proc delete*(s: WxString) = wxString_Delete s

# Converts a WxString to a string (and frees the WxString)
converter toString*(s: WxString): string =
  result = $s
  #echo "DBG: WxString->string conversion for " & result
  s.delete


# Event Handling with Nim Closure support
type
  WxEventHandler* = proc (event: WxEvent) {.closure.}
  YetAnotherClosure = ref object
    eventHandler: WxEventHandler

proc rawEventHandler(fun, data, event: pointer) {.cdecl.} =
  # xxx do not why but that can happen :)
  if event == nil:
    return
  let d = cast[YetAnotherClosure](data).eventHandler
  d(cast[WxEvent](event))

proc connect*(obj: WxWindow; kind: int;  eventHandler: WxEventHandler,
  fromId: WxId = -1, toId: WxId = -1) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # we leak the environment here. This seems to be the best we
  # can do since wxC doesn't offer the possibility to override
  # the destructor of wxClosure in wrapper.h.
  GC_ref(data)
  discard obj.wxEvtHandler_Connect(fromId, toId, kind,
    wxClosure(rawEventHandler, cast[pointer](data)))

proc connect*(obj: WxButton; eventHandler: WxEventHandler) =
  connect(obj, expEVT_COMMAND_BUTTON_CLICKED(), eventHandler)

proc connect*(obj: WxTimerEx; eventHandler: WxEventHandler) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # we leak the environment here. This seems to be the best we
  # can do since wxC doesn't offer the possibility to override
  # the destructor of wxClosure in wrapper.h.
  GC_ref(data)
  obj.wxTimerEx_Connect(wxClosure(rawEventHandler, cast[pointer](data)))

proc wxnRunMainLoop*(main: proc() {.nimcall.}) =
  proc appMain(a, data, c: pointer) {.cdecl.} =
    cast[proc(){.nimcall.}](data)()
  let cl = wxClosure(appMain, main)
  cl.initializeC(0, nil)

# Helpers to make it nicer to use
proc wxPen*(col: WxColour, width: int, style: WxPenStyle): WxPen =
  wxPen_CreateFromColour(col, width, style)

proc wxPen*(colname: string, width: int = 1,
  style: WxPenStyle = wxPENSTYLE_SOLID): WxPen =
  wxPen_CreateFromColour(wxColourByName(colname), width, style)

proc wxBrush*(col: WxColour, style: WxBrushStyle): WxBrush =
  wxBrush_CreateFromColour(col, style)

proc wxBrush*(colname: string, style: WxBrushStyle): WxBrush =
  wxBrush_CreateFromColour(wxColourByName(colname), style)
