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

import unicode

include wxtypes
include wxevents
include wxdefs
include wxprocs

converter toWxId*(x: int): WxId = result = cast[WxId](x)
converter toWxId*(x: WxStandardId): WxId = result = cast[WxId](x)
converter toWxWindow*(x: WxPanel): WxWindow = result = cast[WxWindow](x)

#converter toCInt*(x: WxDirection): cint = result = cast[int64](x)
#converter toCInt*(x: WxStretch): cint = result = cast[cint](x)

type
  MxString* = ref MxStringObj
  MxStringObj* {.final.} = object
    obj: WxString # The real wxString Objekt

# Will extract the WxString from an MxString (if needed)
# But attention: This does not increate the ref-counting
converter toWxString*(obj: MxString): WxString = obj.obj

# convert a WxString into an UTF8 String
proc `$`*(self: WxString): string =
  if self.wxString_Length == 0:
    result = ""
  else:
    var s = newSeq[int32](self.wxString_Length)
    discard wxString_GetString(self, addr s[0])
    result = ""
    for w in s:
      result.add Rune(w).toUTF8

# Free the WxString inside the MxString
proc mxStringFinalizer*(o: MxString) =
  if o.obj != nil:
    # debug what we delete (and when)
    echo "deleting '", $ o.obj, "'"
    wxString_Delete o.obj

# Allocate a GCed "WxString"
proc newMxString*(s: string): MxString =
  new(result, mxStringFinalizer)
  result.obj = wxString_CreateUTF8(s)

type
  MxMessageDialog* = ref MxMessageDialogObj
  MxMessageDialogObj* {.final.} = object
    obj: WxMessageDialog # The real Objekt
    msg: MxString # refholder
    cap: MxString # refholder

proc mxMessageDialogFinalizer*(o: MxMessageDialog) =
  echo "deleting1"
  if o.obj != nil: 
    echo "deleting2"

  if o.msg != nil: 
    wxString_Delete o.msg

  if o.cap != nil: 
    wxString_Delete o.cap

proc mxMessageDialog*(prt: WxWindow, msg: MxString, cap: MxString, spc: WxDialogSpecs): MxMessageDialog =
  echo "creating"
  new(result, mxMessageDialogFinalizer)
  #result.obj = wxString_CreateUTF8(s)
