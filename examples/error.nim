import macros

macro newButton(x: varargs[untyped]): int =
  echo repr(x)
 
proc makeButton(cb: proc()): bool =
  result = newButton(-1)

proc callBack() = discard

discard makeButton(callBack)
