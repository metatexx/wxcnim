# wxevents include

proc expEVT_COMMAND_BUTTON_CLICKED*(): cint
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_COMMAND_MENU_SELECTED*(): cint
  {.cdecl, dynlib: WXCLibName, importc.}
  