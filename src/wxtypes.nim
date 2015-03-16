type WxId* = int

type WxClosure* = pointer
type WxApp* = pointer
type WxString* = pointer

type WxFrame* = pointer
type WxWindow* = pointer
type WxPanel* = pointer

type WxMenu* = pointer
type WxMenuBar* = pointer
type WxMenuItem* = pointer

type WxButton* = pointer

type WxSize* = ptr tuple[w, h: cint]
type WxPos* = ptr tuple[w, h: cint]

#type Rect = (int, int, int, int)
