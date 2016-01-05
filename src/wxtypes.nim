# wxtypes include

when defined(mswindows):
  type WxcWide = int16
else:
  type WxcWide = int32

type WxcWideString* = ptr WxcWide
type WxcArrayWideStrings* = ptr ptr WxcWide

type WxcWideStringShadow* = seq[WxcWide]

type WxcArrayWideStringsShadowObj* = object
  proxy*: WxcArrayWideStrings
  build: seq[WxcWideString]
  shadow: seq[seq[WxcWide]]

type WxcArrayWideStringsShadow* = ref WxcArrayWideStringsShadowObj

type WxId* = int

type
  WxObjectObj {.pure, inheritable.} = object
  WxObject* = ptr WxObjectObj

type WxEvent* = ptr object of WxObject
type WxKeyEvent* = ptr object of WxEvent
type WxTimerEvent* = ptr object of WxEvent
type WxMouseEvent* = ptr object of WxEvent
type WxMenuEvent* = ptr object of WxEvent

type WxTimer* = ptr object of WxObject
type WxTimerEx* = ptr object of WxTimer

type WxClosure* = ptr object
type WxApp* = ptr object
type WxString* = ptr object

type
  WxBitmapObj {.pure, inheritable.} = object
  WxBitmap* = ptr WxBitmapObj

type WxIcon* = ptr object of WxBitmap

type WxColour* = ptr object

type WxFont* = ptr object

# Baseclass for all widgets!
type WxWindow* = ptr object of WxObjectObj

# DC and related
type WxDC* = ptr object of WxObjectObj
type WxClientDC* = ptr object of WxDC
type WxPaintDC* = ptr object of WxDC

type WxPen* = ptr object of WxObjectObj
type WxBrush* = ptr object of WxObjectObj

# container widgets
type WxFrame* = WxWindow
type WxPanel* = WxWindow
type WxScrolledWindow* = WxWindow
type WxGrid* = WxWindow

type WxGridCellEditor* = ptr object
type WxGridCellChoiceEditor* = WxGridCellEditor

# container controls
type WxControl* = WxWindow
type WxListCtrl* = WxControl
type WxStaticText* = WxControl
type WxButton* = WxControl
type WxBitmapButton* = WxControl

type WxMessageDialog* = ptr object

type WxDialog* = ptr object
type WxFileDialog* = WxDialog

type WxClosureTypes* = ptr object

type WxMenu* = ptr object of WxWindow
type WxMenuBar* = ptr object of WxWindow
type WxMenuItem* = ptr object of WxWindow

type WxStatusBar* = ptr object of WxWindow

type WxSizer* = ptr object
type WxBoxSizer* = WxSizer

type WxSizeObj* = tuple[w, h: int]

type WxSize* = ptr tuple[w, h: cint]
type WxPosPtr* = ptr tuple[w, h: cint]
#type Rect = (int, int, int, int)

type WxTextExtent* = tuple[w, h, descent, externalLeading: int]
