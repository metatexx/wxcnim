## wxcnim - wxWidgets for Nim
##
## (c) Hans Raaf - METATEXX GmbH
##
## License MIT (see LICENSE.txt)

when defined(mswindows):
  const WXCLibName* = "wxc.dll"
elif defined(macosx):
  const WXCLibName* = "libwxc.dylib"
else:
  const WXCLibName* = "libwxc.so"

include wxtypes
include wxevents
include wxdefs
include wxprocs

converter toWxId*(x: int): WxId = result = cast[WxId](x)
converter toWxId*(x: WxStandardId): WxId = result = cast[WxId](x)
converter toWxWindow*(x: WxPanel): WxWindow = result = cast[WxWindow](x)

proc newWxString*(s: string): WxString = 
  wxString_CreateUTF8(s)
