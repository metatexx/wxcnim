import wxtypes
import wxdefs
import wxevents
import wxprocs

export wxdefs
export wxevents
export wxtypes
export wxprocs

converter toWxId*(x: int): WxId = result = cast[WxId](x)
converter toWxId*(x: WxStandardId): WxId = result = cast[WxId](x)
converter toWxWindow*(x: WxPanel): WxWindow = result = cast[WxWindow](x)

proc newWxString*(s: string): WxString = 
  wxString_CreateUTF8(s)
