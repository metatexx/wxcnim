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

converter toWxId*(x: int): WxId = result = cast[WxId](x)
converter toWxId*(x: WxStandardId): WxId = cast[WxId](x)

converter toWxClosureTypes*(x: WxApp): WxClosureTypes = cast[WxClosureTypes](x)
converter toWxClosureTypes*(x: WxWindow): WxClosureTypes = cast[WxClosureTypes](x)

# Create a UTF8 String from an WxString (does not consume the WxString)
proc `$`*(self: WxString): string =
  #echo "DBG: Create string from WxString called"
  if self.wxString_Length == 0:
    result = ""
  else:
    when defined(mswindows):
      var s = newSeq[int16](self.wxString_Length)
      discard wxString_GetString(self, addr s[0])
      result = ""
      for w in s:
        result.add Rune(w).toUTF8
    else:
      var s = newSeq[int32](self.wxString_Length)
      discard wxString_GetString(self, addr s[0])
      result = ""
      for w in s:
        result.add Rune(w).toUTF8

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
