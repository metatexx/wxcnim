# Nim version of Minesweeper using the wxcnim module
#
# This is still WIP!
#
# Todos:
#  Make it really random (pseudorandom right now)
#  Add some meaningful buttons(?)
#  Create a Bomb image wich adapts in size(?)

import strutils, os, math

import wxcnim
import mxstring # managed WxString

import nim_crown # the backdrop bitmap

var panel: WxPanel

type
  CellBits = enum
    ckHIDDEN
    ckBOMB
    ckMARK
    ckEXPLODED

  CellKind = tuple[flags: set[CellBits], count: byte]

# we use 1 to 5 as WxId for the level Menu
const levelSizes: array[1..4, (int, int, int)] = [
  (8,8,40),
  (16,16,30),
  (30,16,30),
  (25,25,20)]

template levelString(level: int): string =
  "Level " & $level & " (" & $levelSizes[level][0] & " x " & $levelSizes[level][1] & ")"

proc appMain() =
  wxnInitAllImageHandlers()

  var
    level: int = 1
    fw, fh: int
    normalCells, bombs: int
    fd: seq[CellKind]
    firstClick: bool

  proc cell(x, y: int): var CellKind =
    fd[y * fw + x]

  var unit: int # size of one cell in the GUI

  proc dump() =
    for y in 0 ..< fh:
      var row = ""
      for x in 0 ..< fw:
        if ckBOMB in cell(x, y).flags:
          row &= "*"
        else:
          row &= $cell(x, y).count
      echo row

    echo "Bombs: ", bombs
    echo ""

  proc updateCounts() =
    normalCells = 0;
    bombs = 0
    for i in countdown(fw * fh-1, 0):
      fd[i].count = 0

    for x in 0 ..< fw:
      for y in 0 ..< fh:
        if ckBOMB notin cell(x, y).flags:
          inc normalCells
          for xx in -1 .. 1:
            for yy in -1 .. 1:
              if (xx != 0 or yy != 0) and
                x + xx >= 0 and
                x + xx < fw and
                y + yy >= 0 and
                y + yy < fh and
                ckBOMB in cell(x + xx, y + yy).flags:
                  inc fd[y * fw + x].count

    bombs = fw * fh - normalCells;
    dump()  # cheating :)

  proc createField() =
    firstClick = true # first click guarantees not being a bomb!

    fd = newSeq[CellKind](fw * fh)

    # pseudo random for now
    for i in countdown(fw * fh-1, 0):
      fd[i].flags = if random(15) < 3: { ckHIDDEN, ckBOMB } else: { ckHIDDEN }

  let mainFrame = wxFrame(title="Nim Bombs!",
    stl = wxDEFAULT_DIALOG_STYLE or wxMINIMIZE_BOX)

  let backDrop = wxBitmapFromXPM(addr crownData[0])

  #let icon = wxIconFromXPM(addr icon_data[0])
  #wxIcon_CopyFromBitmap(icon, bmp)
  #wxTopLevelWindow_SetIcon(mainFrame, icon);

  let sizer = wxBoxSizer(wxVertical)
  #let button = wxBitmapButton(mainFrame, wxID_ANY, bmp, 0, 0, -1, -1, wxBORDER_NONE)
  let status = mainFrame.createStatusBar(3)

  mainFrame.setSizer(sizer)
  #panel = wxPanel(mainFrame, wxID_ANY, 0,0, (fw * unit), fh * unit, wxBORDER_NONE)
  panel = wxPanel(mainFrame, wxID_ANY, 0,0, 10, 10, wxBORDER_NONE)

  sizer.addWindow(panel, 1, wxALL, 10)
  #sizer.addWindow(button, 0, wxALL, 10)

  proc updateStatus() =
    status.setStatusText("Bombs: " & $bombs, 0)
    status.setStatusText("Cells: " & $normalCells, 1)
    status.setStatusText("Level: " & $level, 2)

  proc restartLevel() =
    # get level size
    (fw, fh, unit) = levelSizes[level]
    echo fw, " : ", fh
    # resize our panel for the field
    panel.setMinSize(fw * unit, fh * unit)
    # fit the main frame
    mainFrame.fit
    # create out field
    createField()
    # count the bombs
    updateCounts()
    # update status bar counts
    updateStatus()

    panel.refresh()

  proc startLevel(lev: int) =
    level = lev
    restartLevel()

  proc uncoverAll() =
    for f in mitems(fd):
      f.flags.excl(ckHIDDEN)
    panel.refresh()

  proc uncover(x, y: int) =
    if x >= 0 and x < fw and y >= 0 and y < fh:
      var (flags, count) = cell(x, y)
      # not marked? and hidden?
      if ckMARK notin flags and ckHIDDEN in flags:
        # wft.. boom!
        if ckBOMB in flags:
          if firstClick:
            # if we hit the bomb with the first click
            # we move it to another random place :)
            #echo "FIRST"
            # remove the bomb from here
            cell(x, y).flags.excl( ckBOMB )
            # find the new place for the bomb
            while true:
              var
                rx = random(fw)
                ry = random(fh)
              if rx != x and ry != y and ckBOMB notin cell(rx, ry).flags:
                cell(rx, ry).flags.incl(ckBOMB)
                break
            # update the counts for the field
            updateCounts()
            # update our vars so we can simply continue
            (flags, count) = cell(x, y)
          else:
            #echo "BOOM"
            cell(x, y).flags.incl( ckEXPLODED )
            normalCells = 0
            updateStatus()
            uncoverAll()
            wxnBell() # whatever sound it makes
            return

        # we did some unhiding here for sure
        firstClick = false

        # uncover field
        flags.excl( ckHIDDEN )
        # update cell
        cell(x, y).flags = flags

        if flags == {} and count == 0:
            for xx in -1 .. 1:
              for yy in -1 .. 1:
                if xx != 0 or yy != 0:
                  uncover(x + xx, y + yy)

        dec normal_cells
        updateStatus()
        if normal_cells == 0:
          uncoverAll()
          let msgDlg = wxMessageDialog_Create(
            panel,
            "You have found all the bombs!",
            "wxNimBombs",
            wxOK)# or wxICON_INFORMATION)
          discard msgDlg.showModal()
          restartLevel()

  # Menu
  let menuBar = wxMenuBar(0)
  let levelMenu = wxMenu("", 0)
  for idx,siz in levelSizes:
    let levelItem = wxMenuItemEx(idx, levelString(idx), "", 0, nil)
    levelMenu.appendItem(levelItem)

  let restartItem = wxMenuItemEx(-1, "Restart", "R", 0, nil)
  levelMenu.appendItem(restartItem)
  let giveUpItem = wxMenuItemEx(-1, "Give Up", "", 0, nil)
  levelMenu.appendItem(giveUpItem)

  discard menuBar.append(levelMenu, "Level")
  mainFrame.setMenuBar(menuBar)

  #menuBar.connect(expEVT_COMMAND_MENU_SELECTED(), myMenuQuit, fileQuit, fileQuitId)
  #menuBar.connect(expEVT_COMMAND_MENU_SELECTED(), myMenuOpen, fileOpenId, fileOpenId)

  # level selection menu
  menuBar.connect(expEVT_COMMAND_MENU_SELECTED(), levelSizes.low, levelSizes.high) do(evn: WxEvent):
    startLevel(evn.getId())

  # restart menu
  menuBar.connect(restartItem) do(evn: WxEvent):
    restartLevel()

  # giveUp menu
  menuBar.connect(giveUpItem) do(evn: WxEvent):
    uncoverAll()

  mainFrame.connect() do(evn: WxEvent):
    restartLevel()

  # uncover a field
  panel.connect(expEVT_LEFT_DOWN()) do(evn: WxEvent):
    let evn = WxMouseEvent(evn)
    if normalCells == 0:
      return
    let x = evn.getX() div unit
    let y = evn.getY() div unit
    uncover(x,y)
    panel.refresh()

  # add a "Marker"
  panel.connect(expEVT_RIGHT_DOWN()) do(evn: WxEvent):
    let evn = WxMouseEvent(evn)
    if normalCells == 0:
      return
    let x = evn.getX() div unit
    let y = evn.getY() div unit

    let flags = cell(x, y).flags
    if ckHIDDEN in flags:
      # this counts as first click too!
      firstClick = false
      # toggle the mark for this cell
      if ckMARK in flags:
        cell(x, y).flags.excl(ckMARK)
      else:
        cell(x, y).flags.incl(ckMARK)
      panel.refresh()

  ## Paint the playfield
  panel.connect(expEVT_PAINT()) do(evn: WxEvent):
    let brushGrey {.global.} = wxBrush(wxColourRGB(160,160,160))
    #let brushGrey = wxGreyBrush()
    #let brushWhite {.global.} = wxBrush(wxColourRGB(255,255,255))
    let brushWhite {.global.} = wxWhiteBrush()
    let brushRed {.global.} = wxRedBrush()

    let dc = wxPaintDC(panel) # PaintDC because we are in PaintEvent

    # create a matching font for the unit size
    let font = wxDefaultFont()
    font.setPointSize(unit * 60 div 100)
    dc.setFont(font)

    #echo validColourName("RAINBOW") #is false :)
    #echo validColourName("MEDIUM FOREST GREEN") #is true :)

    for x in 0 ..< fw:
      for y in 0 ..< fh:
        let (flags, count) = cell(x, y)

        if (ckHIDDEN in flags) or (ckMARK in flags):
          dc.setBrush(brushGrey)
        elif ckBOMB in flags:
          dc.setBrush(brushRed)
        else:
          dc.setBrush(brushWhite)

        dc.setPen(wxBlackPen())
        dc.drawRectangle(x * unit, y * unit, unit-1, unit-1)

        var txt: MxString
        let col: WxColour = wxColourRGB(0,0,0) # allocated, delete later
        var cross: WxPen = nil

        if ckMARK in flags:
          txt = "M"
          if ckBOMB in flags and ckHIDDEN notin flags:
            col.set("BLUE") # just showing that it works with names
            cross = wxPen(0,0,0) # not wxBlackPen() because we have no static
                                 # blue one and so we need to delete it later
          else:
            col.set(255,0,0)
        elif ckHIDDEN notin flags:
          if ckBOMB in flags:
            txt = "B"
          else:
            txt = $count
            case count:
              of 0: col.set(0,180,0)
              of 1: col.set(0,0,255)
              else: col.set(0,0,0)

        if ckEXPLODED in flags:
          cross = wxPen(0,0,255)

        if txt == nil:
          dc.drawBitmap(backDrop, x * unit + (unit - 16) div 2 , y * unit + (unit - 16) div 2)
        else:
          let (w,h,_,_) = dc.getTextExtent(txt)
          dc.setTextForeground(col)
          dc.drawText(txt, x * unit + (unit - w) div 2 , y * unit + (unit - h) div 2)

        if cross != nil:
          dc.setPen(cross)
          dc.drawLine(x * unit, y * unit, x * unit + unit - 1, y * unit + unit - 1 )
          dc.drawLine(x * unit, y * unit + unit - 1, x * unit + unit - 1, y * unit )
          cross.delete # pen is not consumed

        col.delete # colors are not consumed
    # we need to delete it (if not we get drawing artefacts)
    dc.delete

  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

  startLevel(1)

when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain
  # ... Mainloop running here ...
  echo "Done"
