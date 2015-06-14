# wxtypes include

type WxId* = int

type WxClosure* = ptr object
type WxApp* = ptr object
type WxString* = ptr object

type WxBitmap* = ptr object

# Baseclass for all widgets!
type WxWindow* = ptr object

# container widgets
type WxFrame* = WxWindow
type WxPanel* = WxWindow

# container controls
type WxControl* = WxWindow
type WxListCtrl* = WxControl
type WxStaticText* = WxControl
type WxButton* = WxControl
type WxBitmapButton* = WxControl

type WxMessageDialog* = ptr object

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
