# wxdefs include

type WxStandardID* = enum
  wxID_AUTO_LOWEST = -32000,
  wxID_AUTO_HIGHEST = -2000,

#  wxID_AUTO_LOWEST = -1000000,
#  wxID_AUTO_HIGHEST = -2000,

  # no id matches this one when compared to it
  wxID_NONE = -3,

  # id for a separator line in the menu (invalid for normal item)
  wxID_SEPARATOR = -2,

  # any id: means that we don't care about the id, whether when installing
  # an event handler or when creating a new window */
  wxID_ANY = -1,

  # all predefined ids are between wxID_LOWEST and wxID_HIGHEST */
  wxID_LOWEST = 4999,

  wxID_OPEN,
  wxID_CLOSE,
  wxID_NEW,
  wxID_SAVE,
  wxID_SAVEAS,
  wxID_REVERT,
  wxID_EXIT,
  wxID_UNDO,
  wxID_REDO,
  wxID_HELP,
  wxID_PRINT,
  wxID_PRINT_SETUP,
  wxID_PAGE_SETUP,
  wxID_PREVIEW,
  wxID_ABOUT,
  wxID_HELP_CONTENTS,
  wxID_HELP_INDEX,
  wxID_HELP_SEARCH,
  wxID_HELP_COMMANDS,
  wxID_HELP_PROCEDURES,
  wxID_HELP_CONTEXT,
  wxID_CLOSE_ALL,
  wxID_PREFERENCES,

  wxID_EDIT = 5030,
  wxID_CUT,
  wxID_COPY,
  wxID_PASTE,
  wxID_CLEAR,
  wxID_FIND,
  wxID_DUPLICATE,
  wxID_SELECTALL,
  wxID_DELETE,
  wxID_REPLACE,
  wxID_REPLACE_ALL,
  wxID_PROPERTIES,

  wxID_VIEW_DETAILS,
  wxID_VIEW_LARGEICONS,
  wxID_VIEW_SMALLICONS,
  wxID_VIEW_LIST,
  wxID_VIEW_SORTDATE,
  wxID_VIEW_SORTNAME,
  wxID_VIEW_SORTSIZE,
  wxID_VIEW_SORTTYPE,

  wxID_FILE = 5050,
  wxID_FILE1,
  wxID_FILE2,
  wxID_FILE3,
  wxID_FILE4,
  wxID_FILE5,
  wxID_FILE6,
  wxID_FILE7,
  wxID_FILE8,
  wxID_FILE9,

  # Standard button and menu IDs
  wxID_OK = 5100,
  wxID_CANCEL,
  wxID_APPLY,
  wxID_YES,
  wxID_NO,
  wxID_STATIC,
  wxID_FORWARD,
  wxID_BACKWARD,
  wxID_DEFAULT,
  wxID_MORE,
  wxID_SETUP,
  wxID_RESET,
  wxID_CONTEXT_HELP,
  wxID_YESTOALL,
  wxID_NOTOALL,
  wxID_ABORT,
  wxID_RETRY,
  wxID_IGNORE,
  wxID_ADD,
  wxID_REMOVE,

  wxID_UP,
  wxID_DOWN,
  wxID_HOME,
  wxID_REFRESH,
  wxID_STOP,
  wxID_INDEX,

  wxID_BOLD,
  wxID_ITALIC,
  wxID_JUSTIFY_CENTER,
  wxID_JUSTIFY_FILL,
  wxID_JUSTIFY_RIGHT,
  wxID_JUSTIFY_LEFT,
  wxID_UNDERLINE,
  wxID_INDENT,
  wxID_UNINDENT,
  wxID_ZOOM_100,
  wxID_ZOOM_FIT,
  wxID_ZOOM_IN,
  wxID_ZOOM_OUT,
  wxID_UNDELETE,
  wxID_REVERT_TO_SAVED,
  wxID_CDROM,
  wxID_CONVERT,
  wxID_EXECUTE,
  wxID_FLOPPY,
  wxID_HARDDISK,
  wxID_BOTTOM,
  wxID_FIRST,
  wxID_LAST,
  wxID_TOP,
  wxID_INFO,
  wxID_JUMP_TO,
  wxID_NETWORK,
  wxID_SELECT_COLOR,
  wxID_SELECT_FONT,
  wxID_SORT_ASCENDING,
  wxID_SORT_DESCENDING,
  wxID_SPELL_CHECK,
  wxID_STRIKETHROUGH,

  # System menu IDs (used by wxUniv):
  wxID_SYSTEM_MENU = 5200,
  wxID_CLOSE_FRAME,
  wxID_MOVE_FRAME,
  wxID_RESIZE_FRAME,
  wxID_MAXIMIZE_FRAME,
  wxID_ICONIZE_FRAME,
  wxID_RESTORE_FRAME,

  # MDI window menu ids
  wxID_MDI_WINDOW_FIRST = 5230,
  wxID_MDI_WINDOW_TILE_HORZ,
  wxID_MDI_WINDOW_TILE_VERT,
  wxID_MDI_WINDOW_ARRANGE_ICONS,
  wxID_MDI_WINDOW_PREV,
  wxID_MDI_WINDOW_NEXT, wxID_MDI_WINDOW_LAST,

  # OS X system menu ids
  wxID_OSX_MENU_FIRST = 5250,
  wxID_OSX_HIDEOTHERS,
  wxID_OSX_SHOWALL,

  #if wxABI_VERSION >= 30001
  wxID_OSX_SERVICES,
  #else
  #wxID_OSX_MENU_LAST = wxID_OSX_SHOWALL,
  #endif

  # IDs used by generic file dialog (13 consecutive starting from this value)
  wxID_FILEDLGG = 5900,

  # IDs used by generic file ctrl (4 consecutive starting from this value)
  wxID_FILECTRL = 5950,

  wxID_HIGHEST = 5999

const
  wxID_MDI_WINDOW_CASCADE* = wxID_MDI_WINDOW_FIRST
  wxID_OSX_HIDE* = wxID_MDI_WINDOW_FIRST
  wxID_OSX_MENU_LAST* = wxID_OSX_SERVICES

type WxBorder* = int64

const
  # this is different from wxBORDER_NONE as by default the controls do have border
  wxBORDER_DEFAULT*: WxBorder = 0

  wxBORDER_NONE*: WxBorder = 0x00200000
  wxBORDER_STATIC*: WxBorder = 0x01000000
  wxBORDER_SIMPLE*: WxBorder = 0x02000000
  wxBORDER_RAISED*: WxBorder = 0x04000000
  wxBORDER_SUNKEN*: WxBorder = 0x08000000
  wxBORDER_DOUBLE*: WxBorder = 0x10000000 # deprecated
  wxBORDER_THEME*: WxBorder = wxBORDER_DOUBLE

  # a mask to extract border style from the combination of flags
  wxBORDER_MASK*: WxBorder = 0x1f200000

const wxSIMPLE_BORDER* = wxBORDER_SIMPLE
const wxSTATIC_BORDER* = wxBORDER_STATIC
const wxRAISED_BORDER* = wxBORDER_RAISED
const wxSUNKEN_BORDER* = wxBORDER_SUNKEN

type WxFrameStyle* = int64

const
  wxRESIZE_BORDER*: WxFrameStyle = 64
  wxMAXIMIZE_BOX*: WxFrameStyle = 512
  wxRESIZE_BOX*: WxFrameStyle = wxMAXIMIZE_BOX
  wxMINIMIZE_BOX*: WxFrameStyle = 1024
  wxSYSTEM_MENU*: WxFrameStyle = 2048
  wxCLOSE_BOX*: WxFrameStyle = 4096
  wxMAXIMIZE*: WxFrameStyle = 0x2000
  wxCLIP_CHILDREN*: WxFrameStyle = 4194304
  wxNO_BORDER*: WxFrameStyle = wxBORDER_NONE
  wxCAPTION*: WxFrameStyle = 0x20000000
  wxDEFAULT_FRAME_STYLE*: WxFrameStyle = 536878656
  wxDEFAULT_DIALOG_STYLE*: WxFrameStyle = wxCAPTION or wxMAXIMIZE or wxCLOSE_BOX or wxNO_BORDER

type WxBookcontrolStyle* = int64
const wxBK_DEFAULT*: WxBookcontrolStyle = 0x0000
const wxBK_TOP*: WxBookcontrolStyle = 0x0010
const wxBK_BOTTOM*: WxBookcontrolStyle = 0x0020
const wxBK_LEFT*: WxBookcontrolStyle = 0x0040
const wxBK_RIGHT*: WxBookcontrolStyle = 0x0080
const wxBK_ALIGN_MASK*: WxBookcontrolStyle = wxBK_TOP or wxBK_BOTTOM or wxBK_LEFT or wxBK_RIGHT

type WxNotebookStyle* = int64

const
  wxNB_TOP*: WxNotebookStyle = wxBK_TOP
  wxNB_BOTTOM*: WxNotebookStyle = wxBK_BOTTOM
  wxNB_LEFT*: WxNotebookStyle = wxBK_LEFT
  wxNB_RIGHT*: WxNotebookStyle = wxBK_RIGHT

type WxDialogSpecs* = int64

const
  wxYES*:WxDialogSpecs = 0x00000002
  wxOK*:WxDialogSpecs = 0x00000004
  wxNO*:WxDialogSpecs = 0x00000008
  wxYES_NO*:WxDialogSpecs = wxYES + wxNO
  wxCANCEL*:WxDialogSpecs = 0x00000010
  wxAPPLY*:WxDialogSpecs = 0x00000020
  wxCLOSE*:WxDialogSpecs = 0x00000040

  wxOK_DEFAULT*:WxDialogSpecs = 0x00000000  # has no effect (default)
  wxYES_DEFAULT*:WxDialogSpecs = 0x00000000 # has no effect (default)
  wxNO_DEFAULT*:WxDialogSpecs = 0x00000080  # only valid with wxYES_NO
  wxCANCEL_DEFAULT*:WxDialogSpecs = 0x80000000  # only valid with wxCANCEL

#define wxICON_EXCLAMATION      0x00000100
#define wxICON_HAND             0x00000200
#define wxICON_WARNING          wxICON_EXCLAMATION
#define wxICON_ERROR            wxICON_HAND
#define wxICON_QUESTION         0x00000400
#define wxICON_INFORMATION      0x00000800
#define wxICON_STOP             wxICON_HAND
#define wxICON_ASTERISK         wxICON_INFORMATION

#define wxHELP                  0x00001000
#define wxFORWARD               0x00002000
#define wxBACKWARD              0x00004000
#define wxRESET                 0x00008000
#define wxMORE                  0x00010000
#define wxSETUP                 0x00020000
#define wxICON_NONE             0x00040000
#define wxICON_AUTH_NEEDED      0x00080000

#define wxICON_MASK (wxICON_EXCLAMATION|wxICON_HAND|wxICON_QUESTION|wxICON_INFORMATION|wxICON_NONE|wxICON_AUTH_NEEDED)

type WxAlignment* = int64
const
  # 0 is a valid wxAlignment value (both wxALIGN_LEFT and wxALIGN_TOP
  # use it) so define a symbolic name for an invalid alignment value
  # which can be assumed to be different from anything else

  wxALIGN_INVALID*: WxAlignment = -1

  wxALIGN_NOT*: WxAlignment = 0x0000
  wxALIGN_CENTER_HORIZONTAL*: WxAlignment = 0x0100
  wxALIGN_CENTRE_HORIZONTAL*: WxAlignment = wxALIGN_CENTER_HORIZONTAL
  wxALIGN_LEFT*: WxAlignment = wxALIGN_NOT
  wxALIGN_TOP*: WxAlignment = wxALIGN_NOT
  wxALIGN_RIGHT*: WxAlignment = 0x0200
  wxALIGN_BOTTOM*: WxAlignment = 0x0400
  wxALIGN_CENTER_VERTICAL*: WxAlignment = 0x0800
  wxALIGN_CENTRE_VERTICAL*: WxAlignment = wxALIGN_CENTER_VERTICAL

  wxALIGN_CENTER*: WxAlignment = wxALIGN_CENTER_HORIZONTAL + wxALIGN_CENTER_VERTICAL
  wxALIGN_CENTRE*: WxAlignment = wxALIGN_CENTER

  # a mask to extract alignment from the combination of flags
  wxALIGN_MASK*: WxAlignment = 0x0f00


type WxLcStyle* = int64

const
  wxLC_VRULES*: WxLcStyle = 0x0001
  wxLC_HRULES*: WxLcStyle = 0x0002
  wxLC_ICON*: WxLcStyle = 0x0004
  wxLC_SMALL_ICON*: WxLcStyle = 0x0008
  wxLC_LIST*: WxLcStyle = 0x0010
  wxLC_REPORT*: WxLcStyle = 0x0020

#define wxLC_ALIGN_TOP       0x0040
#define wxLC_ALIGN_LEFT      0x0080
#define wxLC_AUTOARRANGE     0x0100
#define wxLC_VIRTUAL         0x0200
#define wxLC_EDIT_LABELS     0x0400
#define wxLC_NO_HEADER       0x0800
#define wxLC_NO_SORT_HEADER  0x1000
#define wxLC_SINGLE_SEL      0x2000
#define wxLC_SORT_ASCENDING  0x4000
#define wxLC_SORT_DESCENDING 0x8000

#define wxLC_MASK_TYPE       (wxLC_ICON | wxLC_SMALL_ICON | wxLC_LIST | wxLC_REPORT)
#define wxLC_MASK_ALIGN      (wxLC_ALIGN_TOP | wxLC_ALIGN_LEFT)
#define wxLC_MASK_SORT       (wxLC_SORT_ASCENDING | wxLC_SORT_DESCENDING)

type WxStaticTextStyle* =  int64
const
  wxST_NO_AUTORESIZE*: WxStaticTextStyle = 0x0001
  # free 0x0002 bit
  wxST_ELLIPSIZE_START*: WxStaticTextStyle = 0x0004
  wxST_ELLIPSIZE_MIDDLE*: WxStaticTextStyle = 0x0008
  wxST_ELLIPSIZE_END*: WxStaticTextStyle = 0x0010
  # make those type-safe
  wxST_ALIGN_LEFT*: WxStaticTextStyle = wxALIGN_LEFT
  wxST_ALIGN_RIGHT*: WxStaticTextStyle = wxALIGN_RIGHT
  wxST_ALIGN_CENTER*: WxStaticTextStyle = wxALIGN_CENTER

type WxOrientation* = int64
const
  wxHORIZONTAL*: WxOrientation = 0x0004
  wxVERTICAL*: WxOrientation = 0x0008
  wxBOTH*: WxOrientation = 0x000c
  # a mask to extract orientation from the combination of flags
  wxORIENTATION_MASK*: WxOrientation = wxBOTH

type WxStretch = int64
const
  wxSTRETCH_NOT*: WxStretch = 0x0000
  wxSHRINK*: WxStretch = 0x1000
  wxGROW*: WxStretch = 0x2000
  wxEXPAND*: WxStretch = wxGROW
  wxSHAPED*: WxStretch = 0x4000
  #wxTILE*: WxStretch = wxSHAPED + wxFIXED_MINSIZE

  # a mask to extract stretch from the combination of flags
  wxSTRETCH_MASK*: WxStretch = 0x7000 # sans wxTILE

type WxDirection = int64
const
  wxLEFT*: WxDirection = 0x0010
  wxRIGHT*: WxDirection = 0x0020
  wxUP*: WxDirection = 0x0040
  wxDOWN*: WxDirection = 0x0080

  wxTOP* = wxUP
  wxBOTTOM* = wxDOWN

  wxNORTH* = wxUP
  wxSOUTH* = wxDOWN
  wxWEST* = wxLEFT
  wxEAST* = wxRIGHT

  wxALL* = (wxUP + wxDOWN + wxRIGHT + wxLEFT)

  # a mask to extract direction from the combination of flags
  wxDIRECTION_MASK* = wxALL

type WxBitmapType* = enum
  wxBITMAP_TYPE_INVALID,          # should be == 0 for compatibility!
  wxBITMAP_TYPE_BMP,
  wxBITMAP_TYPE_BMP_RESOURCE,
  #wxBITMAP_TYPE_RESOURCE = wxBITMAP_TYPE_BMP_RESOURCE,
  wxBITMAP_TYPE_ICO,
  wxBITMAP_TYPE_ICO_RESOURCE,
  wxBITMAP_TYPE_CUR,
  wxBITMAP_TYPE_CUR_RESOURCE,
  wxBITMAP_TYPE_XBM,
  wxBITMAP_TYPE_XBM_DATA,
  wxBITMAP_TYPE_XPM,
  wxBITMAP_TYPE_XPM_DATA,
  wxBITMAP_TYPE_TIFF,
  #wxBITMAP_TYPE_TIF = wxBITMAP_TYPE_TIFF,
  wxBITMAP_TYPE_TIFF_RESOURCE,
  #wxBITMAP_TYPE_TIF_RESOURCE = wxBITMAP_TYPE_TIFF_RESOURCE,
  wxBITMAP_TYPE_GIF,
  wxBITMAP_TYPE_GIF_RESOURCE,
  wxBITMAP_TYPE_PNG,
  wxBITMAP_TYPE_PNG_RESOURCE,
  wxBITMAP_TYPE_JPEG,
  wxBITMAP_TYPE_JPEG_RESOURCE,
  wxBITMAP_TYPE_PNM,
  wxBITMAP_TYPE_PNM_RESOURCE,
  wxBITMAP_TYPE_PCX,
  wxBITMAP_TYPE_PCX_RESOURCE,
  wxBITMAP_TYPE_PICT,
  wxBITMAP_TYPE_PICT_RESOURCE,
  wxBITMAP_TYPE_ICON,
  wxBITMAP_TYPE_ICON_RESOURCE,
  wxBITMAP_TYPE_ANI,
  wxBITMAP_TYPE_IFF,
  wxBITMAP_TYPE_TGA,
  wxBITMAP_TYPE_MACCURSOR,
  wxBITMAP_TYPE_MACCURSOR_RESOURCE,

  wxBITMAP_TYPE_MAX,
  wxBITMAP_TYPE_ANY = 50

type WxFileDialogStyle* = int
const
  wxFD_OPEN*: WxFileDialogStyle = 0x0001
  wxFD_SAVE*: WxFileDialogStyle = 0x0002
  wxFD_OVERWRITE_PROMPT*: WxFileDialogStyle = 0x0004
  wxFD_FILE_MUST_EXIST*: WxFileDialogStyle = 0x0010
  wxFD_MULTIPLE*: WxFileDialogStyle = 0x0020
  wxFD_CHANGE_DIR*: WxFileDialogStyle = 0x0080
  wxFD_PREVIEW*: WxFileDialogStyle = 0x0100
  wxFD_DEFAULT_STYLE* = wxFD_OPEN


type WxDeprecatedGUIConstants* = enum
    # Text font families
    wxDEFAULT    = 70,
    wxDECORATIVE,
    wxROMAN,
    wxSCRIPT,
    wxSWISS,
    wxMODERN,
    wxTELETYPE,  # @@@@

    #  Proportional or Fixed width fonts (not yet used)
    wxVARIABLE   = 80,
    wxFIXED,

    wxNORMAL     = 90,
    wxLIGHT,
    wxBOLD,
    # Also wxNORMAL for normal (non-italic text)
    wxITALIC,
    wxSLANT,

    # Pen styles
    wxSOLID      =   100,
    wxDOT,
    wxLONG_DASH,
    wxSHORT_DASH,
    wxDOT_DASH,
    wxUSER_DASH,

    wxTRANSPARENT,

    # Brush & Pen Stippling. Note that a stippled pen cannot be dashed!!
    # Note also that stippling a Pen IS meaningful, because a Line is
    wxSTIPPLE_MASK_OPAQUE, # mask is used for blitting monochrome using text fore and back ground colors
    wxSTIPPLE_MASK,        # mask is used for masking areas in the stipple bitmap (TO DO)
    # drawn with a Pen, and without any Brush -- and it can be stippled.
    wxSTIPPLE =          110#,

    #wxBDIAGONAL_HATCH = wxHATCHSTYLE_BDIAGONAL,
    #wxCROSSDIAG_HATCH = wxHATCHSTYLE_CROSSDIAG,
    #wxFDIAGONAL_HATCH = wxHATCHSTYLE_FDIAGONAL,
    #wxCROSS_HATCH = wxHATCHSTYLE_CROSS,
    #wxHORIZONTAL_HATCH = wxHATCHSTYLE_HORIZONTAL,
    #wxVERTICAL_HATCH = wxHATCHSTYLE_VERTICAL,
    #wxFIRST_HATCH = wxHATCHSTYLE_FIRST,
    #wxLAST_HATCH = wxHATCHSTYLE_LAST


# xxx because following does not work
#type WxPenStyle* = int or WxDeprecatedGUIConstants
# I did this
type WxPenStyle* = int
converter toInt*(x: WxDeprecatedGUIConstants): int = cast[int](x)

const
  wxPENSTYLE_INVALID*: WxPenStyle = -1

  wxPENSTYLE_SOLID*: WxPenStyle = wxSOLID
  wxPENSTYLE_DOT*: WxPenStyle = wxDOT
  wxPENSTYLE_LONG_DASH*: WxPenStyle = wxLONG_DASH
  wxPENSTYLE_SHORT_DASH*: WxPenStyle = wxSHORT_DASH
  wxPENSTYLE_DOT_DASH*: WxPenStyle = wxDOT_DASH
  wxPENSTYLE_USER_DASH*: WxPenStyle = wxUSER_DASH

  wxPENSTYLE_TRANSPARENT*: WxPenStyle = wxTRANSPARENT

  wxPENSTYLE_STIPPLE_MASK_OPAQUE*: WxPenStyle = wxSTIPPLE_MASK_OPAQUE
  wxPENSTYLE_STIPPLE_MASK*: WxPenStyle = wxSTIPPLE_MASK
  wxPENSTYLE_STIPPLE*: WxPenStyle = wxSTIPPLE

#  wxPENSTYLE_BDIAGONAL_HATCH = wxHATCHSTYLE_BDIAGONAL,
#  wxPENSTYLE_CROSSDIAG_HATCH = wxHATCHSTYLE_CROSSDIAG,
#  wxPENSTYLE_FDIAGONAL_HATCH = wxHATCHSTYLE_FDIAGONAL,
#  wxPENSTYLE_CROSS_HATCH = wxHATCHSTYLE_CROSS,
#  wxPENSTYLE_HORIZONTAL_HATCH = wxHATCHSTYLE_HORIZONTAL,
#  wxPENSTYLE_VERTICAL_HATCH = wxHATCHSTYLE_VERTICAL,
#  wxPENSTYLE_FIRST_HATCH = wxHATCHSTYLE_FIRST,
#  wxPENSTYLE_LAST_HATCH = wxHATCHSTYLE_LAST


# xxx because following does not work
#type WxBrushStyle* = int or WxDeprecatedGUIConstants
# I did this (as with the WxPenStyle)
type WxBrushStyle* = int

const
  wxBRUSHSTYLE_INVALID*: WxBrushStyle = -1

  wxBRUSHSTYLE_SOLID*: WxBrushStyle = wxSOLID
  wxBRUSHSTYLE_TRANSPARENT*: WxBrushStyle = wxTRANSPARENT
  wxBRUSHSTYLE_STIPPLE_MASK_OPAQUE*: WxBrushStyle = wxSTIPPLE_MASK_OPAQUE
  wxBRUSHSTYLE_STIPPLE_MASK*: WxBrushStyle = wxSTIPPLE_MASK
  wxBRUSHSTYLE_STIPPLE*: WxBrushStyle = wxSTIPPLE

  #wxBRUSHSTYLE_BDIAGONAL_HATCH = wxHATCHSTYLE_BDIAGONAL,
  #wxBRUSHSTYLE_CROSSDIAG_HATCH = wxHATCHSTYLE_CROSSDIAG,
  #wxBRUSHSTYLE_FDIAGONAL_HATCH = wxHATCHSTYLE_FDIAGONAL,
  #wxBRUSHSTYLE_CROSS_HATCH = wxHATCHSTYLE_CROSS,
  #wxBRUSHSTYLE_HORIZONTAL_HATCH = wxHATCHSTYLE_HORIZONTAL,
  #wxBRUSHSTYLE_VERTICAL_HATCH = wxHATCHSTYLE_VERTICAL,
  #wxBRUSHSTYLE_FIRST_HATCH = wxHATCHSTYLE_FIRST,
  #wxBRUSHSTYLE_LAST_HATCH = wxHATCHSTYLE_LAST

type WxSizeFlags* = int

const
  wxSIZE_AUTO_WIDTH*: WxSizeFlags = 1
  wxSIZE_AUTO_HEIGHT*: WxSizeFlags = 2
  wxSIZE_AUTO*: WxSizeFlags = wxSIZE_AUTO_WIDTH + wxSIZE_AUTO_HEIGHT

const
  wxFULL_REPAINT_ON_RESIZE* = 0x00010000

type WxSTBStyle* = int

const
  wxSTB_SIZEGRIP*: WxSTBStyle = 0x0010
  wxSTB_SHOW_TIPS*: WxSTBStyle = 0x0020
  wxSTB_ELLIPSIZE_START*: WxSTBStyle = 0x0040
  wxSTB_ELLIPSIZE_MIDDLE*: WxSTBStyle = 0x0080
  wxSTB_ELLIPSIZE_END*: WxSTBStyle = 0x0100
  wxSTB_DEFAULT_STYLE* = wxSTB_SIZEGRIP or wxSTB_ELLIPSIZE_END or wxSTB_SHOW_TIPS or wxFULL_REPAINT_ON_RESIZE
  wxSB_NORMAL*: WxSTBStyle = 0x0000
  wxSB_FLAT*: WxSTBStyle = 0x0001
  wxSB_RAISED*: WxSTBStyle = 0x0002
  wxSB_SUNKEN*: WxSTBStyle = 0x0003

type WxTextCtrlStyle* = int

const
  wxTE_MULTILINE*: WxTextCtrlStyle = 0x0020
