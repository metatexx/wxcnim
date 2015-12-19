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
