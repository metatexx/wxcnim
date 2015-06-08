# MxString (a refcounter wrapped WxString)

import wxcnim

type
  MxString* = ref MxStringObj
  MxStringObj* {.final.} = object
    obj: WxString # The real wxString Objekt

# Will extract the WxString from an MxString (if needed)
# But attention: This does not increase the ref-counting
#
# Also consider wxWidgets to consume all objects which
# will destroy the wxString while it is still in the MxString
# if you hand it over to a wxWidgets function.
converter toWxString*(obj: MxString): WxString =
  echo "DBG: Converting MxString to WxSting"
  obj.obj

# Free the WxString inside the MxString
proc mxStringFinalizer*(o: MxString) =
  if o.obj != nil:
    # debug what we delete (and when)
    echo "DBG: deleting MxSting '", $ o.obj, "'"
    wxString_Delete o.obj

# Allocate a GCed "WxString"
proc newMxString*(s: string): MxString =
  echo "DBG: Create MxString from string"
  new(result, mxStringFinalizer)
  result.obj = wxString_CreateUTF8(s)

# Makes a MxString from a "string" just by using
# var s:MxString = "Test"
converter toMxString*(s: string): MxString = 
  echo "DBG: Converting string to MxSting"
  newMxString(s)

# Encapsulate a WxString into a MxString so it gets deleted
# automatically on scope exit!
converter toMxString*(s: WxString): MxString =
  echo "DBG: Converting WxString to MxSting"
  new(result, mxStringFinalizer)
  result.obj = s

proc test() =
  let s:MxString = "Test"
  echo s

when isMainModule:
  test()
  # Forcing a full GC run for debugging my MxString implementation
  echo "Forcing full GC"
  GC_fullCollect()
