# wxevents include
when isMainModule:
  include wxlibname

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

proc expEVT_LEFT_DOWN*(): int
  {.cdecl, dynlib: WXCLibName, importc.}

proc expEVT_RIGHT_DOWN*(): int
  {.cdecl, dynlib: WXCLibName, importc.}
