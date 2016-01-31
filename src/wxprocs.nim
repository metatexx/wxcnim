# wxprocs include

# ELJApp
when isMainModule:
  include wxlibname
  include wxdefs
  include wxtypes

{.push callconv: cdecl, dynlib: WXCLibName .}

proc ELJApp_InitializeC*(closure: WxClosure, argc: int, argv: pointer ) {.importc.}
proc ELJApp_Exit*() {.importc.}
proc ELJApp_ExitMainLoop*() {.importc.}
#proc ELJApp_initialize*(vptr1: pointer, vptr2: pointer, argc: cint, argv: pointer) {.importc.}
proc ELJApp_SetTopWindow*( wnd: WxWindow) {.importc.}
proc ELJApp_GetTopWindow*(): WxWindow {.importc.}
proc ELJApp_MainLoop*(): int {.importc.}
proc ELJApp_GetApp*(): WxApp {.importc.}
proc ELJApp_Pending*(): int {.importc.}
proc ELJApp_Initialized*(): bool {.importc.}
proc ELJApp_DisplaySize*(): WxSize {.importc.}
proc ELJApp_Dispatch*() {.importc.}
proc ELJApp_Bell*() {.importc.}
proc ELJApp_GetUserName*(): WxString {.importc.}
proc ELJApp_InitAllImageHandlers*() {.importc.}
proc ELJApp_GetUserHome*(user: WxString): WxString {.importc.}
proc ELJApp_FindWindowById*(id: WxId, prt: WxWindow = nil): WxWindow {.importc.}

# wxString

proc wxString_CreateUTF8*(buffer: cstring): WxString {.importc.}
proc wxString_Delete*(s: WxString) {.importc.}
proc wxString_Length*(s: WxString): int {.importc.}
proc wxString_GetString*(s: WxString, b: pointer): int {.importc.}
#proc wxClosure_Create*(fun: proc {.stdcall.} , data: pointer): WxClosure {.importc.}
proc wxClosure_Create*(fun: proc (fun, data, evt: pointer) {.cdecl.},
                       data: pointer): WxClosure {.importc.}

# wxFrame
proc wxFrame_Create*(p: WxWindow = nil, id: WxId = WxId(wxID_ANY),
  title: WxString = wxString_CreateUTF8("Default Frame Title"),
  x: int = -1, y: int = -1, w: int = -1, h: int = -1,
  stl: WxFrameStyle = wxDEFAULT_FRAME_STYLE): WxFrame {.importc.}
proc wxFrame_SetMenuBar*(obj: WxFrame, menubar: WxMenuBar) {.importc.}
proc wxFrame_ShowFullScreen*(obj: WxFrame, show: bool, style: int): bool {.importc.}
proc wxFrame_CreateStatusBar*(obj: WxFrame, number: int = 1,
  style: WxSTBStyle = wxSTB_DEFAULT_STYLE): WxStatusBar {.importc.}
proc wxFrame_GetStatusBar*(obj: WxFrame): WxStatusBar {.importc.}
proc wxFrame_SetStatusBar*(obj: WxFrame, status: WxStatusBar) {.importc.}
proc wxFrame_SetStatusText*(obj: WxFrame, text: WxString, num: int) {.importc.}
proc wxStatusBar_SetStatusText*(obj: WxStatusBar, text: WxString, num: int) {.importc.}
proc wxFrame_SetStatusWidths*(obj: WxStatusBar, num: int, widths: pointer) {.importc.}

# wxWindow

proc wxWindow_Raise*(p: WxWindow) {.importc.}
proc wxWindow_Show*(p: WxWindow) {.importc.}
proc wxWindow_Hide*(p: WxWindow) {.importc.}
proc wxWindow_Close*(p: WxWindow, force: bool = false) {.importc.}
proc wxWindow_Fit*(p: WxWindow) {.importc.}
proc wxWindow_FitInside*(p: WxWindow) {.importc.}
proc wxWindow_Layout*(p: WxWindow) {.importc.}
proc wxWindow_SetLabel*(obj: WxWindow, txt: WxString) {.importc.}
proc wxWindow_GetLabel*(obj: WxWindow): WxString {.importc.}
proc wxWindow_SetSizer*(obj: WxWindow, sizer: WxSizer) {.importc.}
proc wxWindow_SetSizeHints*(obj: WxWindow, minW, minH, maxW, maxH, incW, incH: int) {.importc.}
proc wxWindow_SetSize*(obj: WxWindow, lft, top, wdt, hgt: int, sizeFlags: WxSizeFlags = wxSIZE_AUTO) {.importc.}
proc wxWindow_SetBackgroundColour*(obj: WxWindow, colour: WxColour): int {.importc.}
proc wxWindow_SetAutoLayout*(obj: WxWindow, autolayout: bool) {.importc.}
proc wxWindow_SetFocus*(obj: WxWindow) {.importc.}
proc wxWindow_Refresh*(obj: WxWindow, eraseBackground: bool = true) {.importc.}
proc wxWindow_Destroy*(obj: WxWindow): bool {.importc.}

# wxTopLevelWindow

proc wxTopLevelWindow_SetMaxSize*(obj: WxWindow, w,h: int) {.importc.}
proc wxTopLevelWindow_SetMinSize*(obj: WxWindow, w,h: int) {.importc.}
proc wxTopLevelWindow_Maximize*(obj: WxWindow) {.importc.}
proc wxTopLevelWindow_SetIcon*(obj: WxWindow, icon: WxIcon) {.importc.}

# wxIcon

proc wxIcon_CreateDefault*(): WxIcon {.importc.}
proc wxIcon_CopyFromBitmap*(obj: WxIcon, bmp: WxBitmap) {.importc.}
proc wxIcon_CreateLoad*(name: WxString,
  kind: WxBitmapType = wxBITMAP_TYPE_XBM,
  wdt: int = -1, hgt: int = -1): WxIcon {.importc.}
proc wxIcon_FromXPM*(data: pointer): WxIcon {.importc.}

# wxPanel

proc wxPanel_Create*(prt: WxWindow, id: WxId = -1,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: WxBorder = 0): WxPanel {.importc.}

# wxDC

proc wxDC_SetPen*(obj: WxDC, pen: WxPen) {.importc.}
proc wxDC_SetBrush*(obj: WxDC, pen: WxBrush) {.importc.}
proc wxDC_SetFont*(obj: WxDC, font: WxFont) {.importc.}
proc wxDC_DrawCircle*(obj: WxDC, x,y : int, radius: int) {.importc.}
proc wxDC_DrawLine*(obj: WxDC, x1,y1, x2,y2 : int) {.importc.}
proc wxDC_DrawRectangle*(obj: WxDC, left, top, width, height : int) {.importc.}
proc wxDC_DrawText*(obj: WxDC, text: WxString, left, top: int) {.importc.}
proc wxDC_GetTextExtent*(obj: WxDC, text: WxString,
  w, h, descent, externalLeading: pointer, theFont: WxFont) {.importc.}
proc wxDC_GetTextBackground*(obj: WxDC, colour: pointer) {.importc.}
proc wxDC_GetTextForeground*(obj: WxDC, colour: pointer) {.importc.}
proc wxDC_SetTextBackground*(obj: WxDC, colour: WxColour) {.importc.}
proc wxDC_SetTextForeground*(obj: WxDC, colour: WxColour) {.importc.}
proc wxDC_IsOk*(obj: WxDC): bool {.importc.}
proc wxDC_Clear*(obj: WxDC) {.importc.}
proc wxDC_DrawBitmap*(obj: WxDC, bmp: WxBitmap, x: int, y: int, useMask: bool = false ) {.importc.}

# wxClientDC

proc wxClientDC_Create*(win: WxWindow): WxClientDC {.importc.}
proc wxClientDC_Delete*(obj: WxClientDC) {.importc.}

# wxPaintDC

proc wxPaintDC_Create*(win: WxWindow): WxPaintDC {.importc.}
proc wxPaintDC_Delete*(obj: WxPaintDC) {.importc.}

# wxPen

proc wxPen_CreateFromColour*(col: WxColour, width: int, style: WxPenStyle): WxPen {.importc.}
proc wxPen_CreateFromStock*(id: int): WxPen {.importc.}
proc wxPen_Delete*(pen: WxPen) {.importc.}

# wxBrush

proc wxBrush_CreateFromColour*(col: WxColour, style: WxBrushStyle): WxBrush {.importc.}
proc wxBrush_CreateFromStock*(id: int): WxBrush {.importc.}
proc wxBrush_Delete*(brush: WxBrush) {.importc.}

# wxFont

proc wxFont_CreateDefault*(): WxFont {.importc.}
proc wxFont_SetPointSize*(obj: WxFont, pointSize: int) {.importc.}

# wxScrolledWindow

proc wxScrolledWindow_Create*(prt: WxWindow, id: int,
  lft, top, wdt, hgt: int, stl: WxBorder): WxScrolledWindow {.importc.}
proc wxScrolledWindow_AdjustScrollbars*(obj: WxScrolledWindow) {.importc.}
proc wxScrolledWindow_EnableScrolling*(obj: WxScrolledWindow, scrollh, scrollv: bool) {.importc.}
proc wxScrolledWindow_ShowScrollbars*(obj: WxScrolledWindow, showh, showv: int) {.importc.}
proc wxScrolledWindow_SetScrollRate*(obj: WxScrolledWindow, rateh, ratev: int) {.importc.}
proc wxScrolledWindow_SetScrollbars*(obj: WxScrolledWindow,
  pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY,
  xPos, yPos: int, noRefresh:bool ) {.importc.}
proc wxScrolledWindow_Scroll*(obj: WxScrolledWindow, x_pos, y_pos: int) {.importc.}
proc wxScrolledWindow_GetViewStart*(obj: WxScrolledWindow, x: ptr int, y: ptr int) {.importc.}

# wxNotebook
proc wxNotebook_Create*(prt: WxWindow, id: int,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: WxNotebookStyle = 0): WxNotebook {.importc.}
proc wxNotebook_AddPage*(obj: WxNotebook, pPage: WxWindow, label: WxString,
 select: bool, imageID: int=0): bool {.importc.}
proc wxNotebook_SetSelection*(obj: WxNotebook, nPage: int): int {.importc.}

# wxBookCtrlEvent
proc wxBookCtrlEvent_GetSelection*(evn: WxBookCtrlEvent): int {.importc.}
proc wxBookCtrlEvent_GetOldSelection*(evn: WxBookCtrlEvent): int {.importc.}

# wxGrid

proc wxGrid_Create*(prt: WxWindow, id: int,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: int = 0): WxGrid {.importc.}
proc wxGrid_CreateGrid*(obj: WxGrid, rows: int, cols: int, selmode: int) {.importc.}
proc wxGrid_BeginBatch*(obj: WxGrid) {.importc.}
proc wxGrid_EndBatch*(obj: WxGrid) {.importc.}
proc wxGrid_DisableDragColSize*(obj: WxGrid) {.importc.}
proc wxGrid_DisableDragRowSize*(obj: WxGrid) {.importc.}
proc wxGrid_SetCellEditor*(obj: WxGrid, row: int, col: int,
  editor: WxGridCellEditor) {.importc.}
proc wxGrid_SetReadOnly*(obj: WxGrid, row: int, col: int, readOnly: bool) {.importc.}
proc wxGrid_SetCellValue*(obj: WxGrid, row: int, col: int, value: WxString) {.importc.}
proc wxGrid_SetCellTextColour*(obj: WxGrid, row: int, col: int, value: WxColour) {.importc.}

#

proc wxGridCellChoiceEditor_Ctor*( count: int ,  choices: WxcArrayWideStrings,
  alllowOthers = true): WxGridCellChoiceEditor {.importc.}

# wxMenu

proc wxMenu_Create*(title: WxString, style: clong ): WxMenu {.importc.}
proc wxMenu_AppendItem*(obj: WxMenu, itm: WxMenuItem) {.importc.}
proc wxMenu_GetLabelText*(obj: WxWindow): WxString {.importc.}

# wxMenuBar

proc wxMenuBar_Create*(style: int): WxMenuBar {.importc.}
proc wxMenuBar_Append*(onj: WxMenuBar, menu: WxMenu, title: WxString): int {.importc.}

# wxMenuItem

proc wxMenuItem_Create*(): WxMenuItem {.importc.}
proc wxMenuItem_CreateEx*(id: int,
  label: WxString = wxString_CreateUTF8("Does this work?"),
  help: WxString = wxString_CreateUTF8(""),
  itemkind: int = 0, submenu: WxMenu = nil): WxMenuItem {.importc.}
proc wxMenuItem_SetCheckable*(obj: WxMenuItem, checkable: bool) {.importc.}
proc wxMenuItem_SetHelp*(obj: WxMenuItem, str: WxString) {.importc.}
proc wxMenuItem_SetId*(obj: WxMenuItem, id: WxId) {.importc.}
proc wxMenuItem_GetId*(obj: WxMenuItem): WxId {.importc.}
proc wxMenuItem_GetLabelText*(obj: WxWindow): WxString {.importc.}

# void wxMenuItem_SetSubMenu( TSelf(wxMenuItem) _obj, TClass(wxMenu) menu );

proc wxMenuItem_SetItemLabel*(obj: WxMenuItem, str: WxString) {.importc.}

# wxButton

proc wxButton_Create*(prt: WxWindow, id: WxId, txt: WxString,
  left: int = -1, top: int = -1, width: int = -1, heigth: int = -1,
  style: int64 = 0): WxButton {.importc.}

# wxColour

proc wxColour_CreateRGB*(red, green, blue, alpha: int = 255): WxColour {.importc.}
proc wxColour_CreateByName*(name: WxString): WxColour {.importc.}
proc wxColour_CreateEmpty*(): WxColour {.importc.}
proc wxColour_CreateFromStock*(id: int): WxColour {.importc.}
proc wxColour_Delete*(col: WxColour) {.importc.}
proc wxColour_Set*(col: WxColour, red, green, blue, alpha: int = 255) {.importc.}
proc wxColour_SetByName*(col: WxColour, name: WxString) {.importc.}
proc wxColour_ValidName*(name: WxString): bool {.importc.}
proc wxColour_Copy*(col: WxColour): WxColour {.importc.}
proc wxColour_Alpha*(col: WxColour): int {.importc.}
proc wxColour_Red*(col: WxColour): int {.importc.}
proc wxColour_Green*(col: WxColour): int {.importc.}
proc wxColour_Blue*(col: WxColour): int {.importc.}

# wxBitmap

proc wxBitmap_CreateLoad*(name: WxString, kind: WxBitmapType): WxBitmap {.importc.}
proc wxBitmap_CreateFromXPM*(data: pointer): WxBitmap {.importc.}
proc wxBitmap_Delete*(obj: WxBitmap) {.importc.}
proc wxBitmap_GetHeight*(obj: WxBitmap): int {.importc.}
proc wxBitmap_GetWidth*(obj: WxBitmap): int {.importc.}

# wxBitmapButton

proc wxBitmapButton_Create*(prt: WxWindow, id: int, bmp: WxBitmap,
  lft, top, wdt, hgt: int, stl: WxBorder): WxBitmapButton {.importc.}

# wxBoxSizer

#TClass(wxSize) wxBoxSizer_CalcMin( TSelf(wxBoxSizer) _obj );
proc wxBoxSizer_Create*(orient: WxOrientation = wxVERTICAL): WxBoxSizer {.importc.}
#int        wxBoxSizer_GetOrientation( TSelf(wxBoxSizer) _obj );
#void       wxBoxSizer_RecalcSizes( TSelf(wxBoxSizer) _obj );

# wxSizer (abstract)

proc wxSizer_Add*(obj: WxSizer, width: int = 0, heigth: int = 0, opt: int = 0,
  flags: WxStretch = 0, border: int = 0, udt: pointer = nil) {.importc.}
proc wxSizer_AddWindow*(obj: WxSizer, wnd: WxWindow, opt: int = 0,
  flg: WxStretch = 0, brd: int = 0, udt: pointer = nil) {.importc.}
proc wxSizer_AddSizer*(obj: WxSizer, sizer: WxSizer, opt: int = 0,
  flg: WxStretch = 0, brd: int = 0, udt: pointer = nil) {.importc.}
proc wxSizer_Layout*(obj: WxSizer) {.importc.}
proc wxSizer_SetSizeHints*(obj: WxSizer, wnd: WxWindow) {.importc.}

#TClass(wxSize) wxSizer_CalcMin( TSelf(wxSizer) _obj );

# wxStaticBox

proc wxStaticBox_Create*(prt: WxWindow, id: WxId, label: WxString,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: int = 0): WxStaticBox {.importc.}

# wxStaticBoxSizer

proc wxStaticBoxSizer_Create*(box: WxStaticBox,
  orient: WxOrientation = wxVERTICAL): WxBoxSizer {.importc.}

# wxControl

proc wxControl_SetLabel*(obj: WxControl, txt: WxString) {.importc.}

# wxStaticText

proc wxStaticText_Create*(prt: WxWindow, id: WxId, txt: WxString,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  stl: WxStaticTextStyle): WxStaticText {.importc.}

# wxTextCtrl

proc wxTextCtrl_Create*(prt: WxWindow, id: WxId, text: WxString,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  style: WxTextCtrlStyle = 0): WxTextCtrl {.importc.}
proc wxTextCtrl_AppendText*(obj: WxTextCtrl, text: WxString) {.importc.}

# wxListCtrl

proc wxListCtrl_Create*(prt: WxWindow, id: WxId,
  lft: int, top: int, wdt: int, hgt: int, stl: WxLCStyle): WxListCtrl {.importc.}
proc wxListCtrl_InsertColumn*(obj: WxListCtrl, col: int,
  heading: WxString, format: int, width: int): int {.importc.}
proc wxListCtrl_GetColumnCount*(obj: WxListCtrl): int {.importc.}

# wxCheckListBox

proc wxCheckListBox_Create*(prt: WxWindow, id: WxId,
  left: int = -1, top: int = -1, width: int = -1, height: int = -1,
  n: int, str: WxcArrayWideStrings, style: int64 ) : WxCheckListBox {.importc.}
proc wxCheckListBox_Delete*(obj: WxCheckListBox) {.importc.}
proc wxCheckListBox_IsChecked*(obj: WxCheckListBox, item: int): bool {.importc.}

# wxEvtHandler

proc wxEvtHandler_Connect*(obj: WxWindow, first: WxId = -1, last: WxId = -1,
 kind: int, data: WxClosure): int {.importc.}

# wxEvent

proc wxEvent_GetEventType*(obj: WxEvent): int {.importc.}
proc wxEvent_GetEventObject*(obj: WxEvent): WxWindow {.importc.}
proc wxEvent_GetId*(obj: WxEvent): int {.importc.}
proc wxEvent_GetTimestamp*(obj: WxEvent): int {.importc.}
proc wxEvent_SetId*(obj: WxEvent, id: int) {.importc.}
proc wxEvent_Skip*(obj: WxEvent) {.importc.}

# wxNotifyEvent

proc wxNotifyEvent_Veto*(obj: WxNotifyEvent) {.importc.}

# wxKeyEvent

proc wxKeyEvent_GetKeyCode*(obj: WxKeyEvent): int {.importc.}
proc wxKeyEvent_GetModifiers*(obj: WxKeyEvent): int {.importc.}
proc wxKeyEvent_GetX*(obj: WxKeyEvent): int {.importc.}
proc wxKeyEvent_GetY*(obj: WxKeyEvent): int {.importc.}

# wxMouseEvent

proc wxMouseEvent_GetX*(obj: WxMouseEvent): int {.importc.}
proc wxMouseEvent_GetY*(obj: WxMouseEvent): int {.importc.}

# wxMenuEvent

proc wxMenuEvent_GetMenuId*(obj: WxMenuEvent): int {.importc.}

# wxTimer

proc wxTimer_Create*(prt: WxWindow, id: WxId): WxTimer {.importc.}
proc wxTimer_Delete*(obj: WxTimer) {.importc.}
proc wxTimer_Start*(obj: WxTimer, millisecs: int = 1000, oneshot: bool = false): bool {.importc.}
proc wxTimer_Stop*(obj: WxTimer) {.importc.}
proc wxTimer_GetInterval*(evn: WxTimer): int {.importc.}
proc wxTimer_IsOneShot*(evn: WxTimer): bool {.importc.}
proc wxTimer_IsRuning*(evn: WxTimer): bool {.importc.}

# wxTimerEx

proc wxTimerEx_Create*(): WxTimerEx {.importc.}
proc wxTimerEx_Connect*(timer: WxTimerEx, cl: WxClosure) {.importc.}

# wxTimerEvent

proc wxTimerEvent_GetInterval*(evn: WxTimerEvent): int {.importc.}

# wxDialog

proc wxDialog_ShowModal*(obj: WxDialog): int {.importc.}

# wxMessageDialog

proc wxMessageDialog_Create*(prt: WxWindow, msg: WxString, cap: WxString,
  spc: WxDialogSpecs): WxMessageDialog {.importc.}
proc wxMessageDialog_Delete*(obj: WxMessageDialog) {.importc.}
proc wxMessageDialog_ShowModal*(obj: WxMessageDialog): WxId {.importc.}

# wxFileDialog

proc wxFileDialog_Create*(prt: WxWindow, msg: WxString, dir: WxString,
  fle: WxString, wcd: WxString,
  lft: int = 0, top: int = 0,
  stl: WxFileDialogStyle = wxFD_DEFAULT_STYLE): WxFileDialog {.importc.}
proc wxFileDialog_GetPath*(obj: WxFileDialog): WxString {.importc.}

{.pop.}

# (c) Hans Raaf - METATEXX GmbH
