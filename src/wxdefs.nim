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

type WxFrameStyle* = int64

const
  wxRESIZE_BORDER*:WxFrameStyle = 64
  wxMAXIMIZE_BOX*:WxFrameStyle = 512
  wxMINIMIZE_BOX*:WxFrameStyle = 1024
  wxSYSTEM_MENU*:WxFrameStyle = 2048
  wxCLOSE_BOX*:WxFrameStyle = 4096
  wxCLIP_CHILDREN*:WxFrameStyle = 4194304
  wxCAPTION*:WxFrameStyle = 0x20000000
  wxDEFAULT_FRAME_STYLE*:WxFrameStyle = 536878656    

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
