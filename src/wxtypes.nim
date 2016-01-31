# wxtypes include

when defined(mswindows):
  type WxcWide = int16
else:
  type WxcWide = int32

type
  WxcWideString* = ptr WxcWide
  WxcArrayWideStrings* = ptr ptr WxcWide

  WxcWideStringShadow* = seq[WxcWide]

  WxcArrayWideStringsShadowObj* = object
    proxy*: WxcArrayWideStrings
    build: seq[WxcWideString]
    shadow: seq[seq[WxcWide]]

  WxcArrayWideStringsShadow* = ref WxcArrayWideStringsShadowObj

  WxId* = int

  WxObjectObj {.pure, inheritable.} = object
  WxObject* = ptr WxObjectObj

  WxEvent* = ptr object of WxObject
  WxNotifyEvent* = ptr object of WxEvent
  WxKeyEvent* = ptr object of WxEvent
  WxTimerEvent* = ptr object of WxEvent
  WxMouseEvent* = ptr object of WxEvent
  WxMenuEvent* = ptr object of WxEvent
  WxBookCtrlEvent* = ptr object of WxNotifyEvent

  WxTimer* = ptr object of WxObject
  WxTimerEx* = ptr object of WxTimer

  WxClosure* = ptr object
  WxApp* = ptr object
  WxString* = ptr object

  WxBitmapObj {.pure, inheritable.} = object
  WxBitmap* = ptr WxBitmapObj

  WxIcon* = ptr object of WxBitmap

  WxColour* = ptr object

  WxFont* = ptr object

  # Baseclass for all widgets!
  WxWindow* = ptr object of WxObjectObj

  # DC related
  WxDC* = ptr object of WxObjectObj
  WxClientDC* = ptr object of WxDC
  WxPaintDC* = ptr object of WxDC

  WxPen* = ptr object of WxObjectObj
  WxBrush* = ptr object of WxObjectObj

  # container widgets
  WxFrame* = WxWindow
  WxPanel* = WxWindow
  WxScrolledWindow* = WxWindow
  WxGrid* = WxWindow

  WxGridCellEditor* = ptr object
  WxGridCellChoiceEditor* = WxGridCellEditor

  # container controls
  WxControl* = WxWindow
  WxListCtrl* = WxControl
  WxTextCtrl* = WxControl
  WxStaticText* = WxControl
  WxButton* = WxControl
  WxBitmapButton* = WxControl
  WxNotebook* = WxControl
  WxStaticBox* = WxControl
  WxCheckListBox* = WxControl

  WxMessageDialog* = ptr object

  WxDialog* = ptr object
  WxFileDialog* = WxDialog

  WxClosureTypes* = ptr object

  WxMenu* = ptr object of WxWindow
  WxMenuBar* = ptr object of WxWindow
  WxMenuItem* = ptr object of WxWindow

  WxStatusBar* = ptr object of WxWindow

  WxSizer* = ptr object
  WxBoxSizer* = WxSizer

  WxSizeObj* = tuple[w, h: int]

  WxSize* = ptr tuple[w, h: cint]
  WxPosPtr* = ptr tuple[w, h: cint]
#  Rect = (int, int, int, int)

  WxTextExtent* = tuple[w, h, descent, externalLeading: int]
