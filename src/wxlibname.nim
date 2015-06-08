when defined(mswindows):
  const WXCLibName* = "wxc.dll"
elif defined(macosx):
  const WXCLibName* = "libwxc.dylib"
else:
  const WXCLibName* = "libwxc.so"
