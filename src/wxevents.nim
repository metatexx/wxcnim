# wxevents include

proc expEVT_COMMAND_BUTTON_CLICKED*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_COMMAND_MENU_SELECTED*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_KEY_UP*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_TIMER*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_PAINT*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

type
  EventHandler* = proc (event: WxEvent) {.closure.}
  YetAnotherClosure = ref object
    eventHandler: EventHandler

proc rawEventHandler(fun, data, event: pointer) {.cdecl.} =
  let d = cast[YetAnotherClosure](data).eventHandler
  d(cast[WxEvent](event))

proc register*(obj: WxWindow; kind: int;
               eventHandler: EventHandler) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # we leak the environment here. This seems to be the best we
  # can do since wxC doesn't offer the possibility to override
  # the destructor of wxClosure in wrapper.h.
  GC_ref(data)
  discard obj.connect(-1, -1, kind, wxClosure(rawEventHandler, cast[pointer](data)))

proc register*(obj: WxButton; eventHandler: EventHandler) =
  register(obj, expEVT_COMMAND_BUTTON_CLICKED(), eventHandler)

proc register*(obj: WxTimerEx; eventHandler: EventHandler) =
  let data = YetAnotherClosure(eventHandler: eventHandler)
  # we leak the environment here. This seems to be the best we
  # can do since wxC doesn't offer the possibility to override
  # the destructor of wxClosure in wrapper.h.
  GC_ref(data)
  obj.wxTimerEx_Connect(wxClosure(rawEventHandler, cast[pointer](data)))

proc callMain*(main: proc() {.nimcall.}) =
  proc appMain(a, data, c: pointer) {.cdecl.} =
    cast[proc(){.nimcall.}](data)()
  let cl = wxClosure(appMain, main)
  cl.initializeC(0, nil)
