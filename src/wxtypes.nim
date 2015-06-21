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

type WxClosure* = ptr object
type WxApp* = ptr object
type WxString* = ptr object

type WxBitmap* = ptr object

type WxColour* = ptr object

# Baseclass for all widgets!
type WxWindow* = ptr object

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

type WxMenu* = ptr object
type WxMenuBar* = ptr object
type WxMenuItem* = ptr object

type WxSizer* = ptr object
type WxBoxSizer* = WxSizer

type WxSizeObj* = tuple[w, h: int]

type WxSize* = ptr tuple[w, h: cint]
type WxPosPtr* = ptr tuple[w, h: cint]
#type Rect = (int, int, int, int)
