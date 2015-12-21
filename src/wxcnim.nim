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

  WxEventHandlerM* = proc (event: WxMouseEvent) {.closure.}
  YetAnotherClosureM = ref object
    eventHandler: WxEventHandlerM

proc rawEventHandler(fun, data, event: pointer) {.cdecl.} =
  if event == nil:
    # gets called with nil on destruction of the closure
    GC_unref(cast[ref YetAnotherClosure](data))
    return
  let d = cast[YetAnotherClosure](data).eventHandler
  d(cast[WxEvent](event))

proc rawEventHandlerM(fun, data, event: pointer) {.cdecl.} =
  if event == nil:
    # gets called with nil on destruction of the closure
    GC_unref(cast[ref YetAnotherClosureM](data))
    return
  let d = cast[YetAnotherClosureM](data).eventHandler
  d(cast[WxMouseEvent](event))

proc connect*(obj: WxWindow; kind: int;  eventHandler: WxEventHandler,
  fromId: WxId = -1, toId: WxId = -1) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # will be unref on destruction of the underlaying closure
  GC_ref(data)
  discard obj.wxEvtHandler_Connect(fromId, toId, kind,
    wxClosure(rawEventHandler, cast[pointer](data)))

proc connect*(obj: WxWindow; kind: int;  eventHandler: WxEventHandlerM,
  fromId: WxId = -1, toId: WxId = -1) =
  let data = YetAnotherClosureM(eventHandler: eventHandler)
  # will be unref on destruction of the underlaying closure
  GC_ref(data)
  discard obj.wxEvtHandler_Connect(fromId, toId, kind,
    wxClosure(rawEventHandlerM, cast[pointer](data)))

proc connect*(obj: WxButton; eventHandler: WxEventHandler) =
  connect(obj, expEVT_COMMAND_BUTTON_CLICKED(), eventHandler)

proc connect*(obj: WxTimerEx; eventHandler: WxEventHandler) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # will be unref on destruction of the underlaying closure
  GC_ref(data)
  obj.wxTimerEx_Connect(wxClosure(rawEventHandler, cast[pointer](data)))

proc wxnRunMainLoop*(main: proc() {.nimcall.}) =
  proc appMain(a, data, c: pointer) {.cdecl.} =
    cast[proc(){.nimcall.}](data)()
  let cl = wxClosure(appMain, main)
  cl.initializeC(0, nil)

# Helpers to make it nicer to use
proc wxPen*(col: WxColour, width: int = 1,
  style: WxPenStyle = wxPENSTYLE_SOLID): WxPen =
  wxPen_CreateFromColour(col, width, style)

proc wxPen*(colname: string, width: int = 1,
  style: WxPenStyle = wxPENSTYLE_SOLID): WxPen =
  wxPen_CreateFromColour(wxColourByName(colname), width, style)

proc wxPen*(r,g,b: int, width: int = 1,
  style: WxPenStyle = wxPENSTYLE_SOLID): WxPen =
  wxPen_CreateFromColour(wxColourRGB(r,g,b), width, style)

# its magic colors :)
proc wxRedPen*(): WxPen = wxPen_CreateFromStock(0)
proc wxCyanPen*(): WxPen = wxPen_CreateFromStock(1)
proc wxGreenPen*(): WxPen = wxPen_CreateFromStock(2)
proc wxBlackPen*(): WxPen = wxPen_CreateFromStock(3)
proc wxWhitePen*(): WxPen = wxPen_CreateFromStock(4)
proc wxTransparentPen*(): WxPen = wxPen_CreateFromStock(5)
proc wxBlackDashedPen*(): WxPen = wxPen_CreateFromStock(6)
proc wxGreyPen*(): WxPen = wxPen_CreateFromStock(7)
proc wxMediumGreyPen*(): WxPen = wxPen_CreateFromStock(8)
proc wxLightGreyPen*(): WxPen = wxPen_CreateFromStock(9)

proc wxBrush*(col: WxColour, style: WxBrushStyle = wxBRUSHSTYLE_SOLID): WxBrush =
  wxBrush_CreateFromColour(col, style)

proc wxBrush*(colname: string, style: WxBrushStyle = wxBRUSHSTYLE_SOLID): WxBrush =
  wxBrush_CreateFromColour(wxColourByName(colname), style)

proc wxBlueBrush*(): WxBrush = wxBrush_CreateFromStock(0)
proc wxGreenBrush*(): WxBrush = wxBrush_CreateFromStock(1)
proc wxWhiteBrush*(): WxBrush = wxBrush_CreateFromStock(2)
proc wxBlackBrush*(): WxBrush = wxBrush_CreateFromStock(3)
proc wxGreyBrush*(): WxBrush = wxBrush_CreateFromStock(4)
proc wxMediumGreyBrush*(): WxBrush = wxBrush_CreateFromStock(5)
proc wxLightGreyBrush*(): WxBrush = wxBrush_CreateFromStock(6)
proc wxTransparentBrush*(): WxBrush = wxBrush_CreateFromStock(7)
proc wxCyanBrush*(): WxBrush = wxBrush_CreateFromStock(8)
proc wxRedBrush*(): WxBrush = wxBrush_CreateFromStock(9)
