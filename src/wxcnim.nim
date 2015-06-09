## wxcnim - wxWidgets for Nim
##
## (c) Hans Raaf - METATEXX GmbH
##
## License MIT (see LICENSE.txt)

include wxlibname

import unicode

include wxtypes
include wxevents
include wxdefs
include wxprocs

include wxunpacking

#template wxPos*(x:int ,y:int): stmt {.immediate.} =
#  x, y

converter toWxId*(x: int): WxId = result = cast[WxId](x)
converter toWxId*(x: WxStandardId): WxId = cast[WxId](x)
converter toWxWindow*(x: WxPanel): WxWindow = cast[WxWindow](x)

#converter toCInt*(x: WxAlignment): cint = cast[cint](x)
#converter toCInt*(x: WxDirection): cint = result = cast[int64](x)
#converter toCInt*(x: WxStretch): cint = result = cast[cint](x)

# convert a WxString into an UTF8 String
proc `$`*(self: WxString): string =
  echo "DBG: Create string from WxString called"
  if self.wxString_Length == 0:
    result = ""
  else:
    var s = newSeq[int32](self.wxString_Length)
    discard wxString_GetString(self, addr s[0])
    result = ""
    for w in s:
      result.add Rune(w).toUTF8

# Makes a WxString from a "string"
converter toWxString*(s: string): WxString = 
  echo "DBG: string->WxString conversion for " & s
  result = wxString_CreateUTF8(s)

# Deleting a WxString (which was returned by a funtion)
proc delete*(s: WxString) = wxString_Delete s

converter toString*(s: WxString): string =
  result = $s
  echo "DBG: WxString->string conversion for " & result
  s.delete
