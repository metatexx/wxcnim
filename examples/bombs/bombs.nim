# Simple version of Minesweeper
#
# This is still WIP!
#
# Todos:
#  Fix first click behavior (no bomb!)
#  Make different level (sizes)

import wxcnim
import mxstring # managed WxString

import strutils
import os
import math

include icon_data

var panel: WxPanel

const UNIT = 30

type
  CellBits = enum
    ckHIDDEN
    ckBOMB
    ckMARK
    ckEXPLODED

  CellKind = tuple[flags: set[CellBits], count: byte]

proc appMain() =
  wxnInitAllImageHandlers()

  var
    level: int = 1
    fw, fh: int
    normalCells, bombs: int
    fd: seq[CellKind]

  proc cell(x, y: int): var CellKind =
    fd[y * fw + x]

  proc dump() =
    for y in 0 ..< fw:
      var row = ""
      for x in 0 ..< fh:
        if ckBOMB in cell(x, y).flags:
          row &= "*"
        else:
          row &= $cell(x, y).count
      echo row

  fw = 10
  fh = 10

  proc createField() =
    level = 1
    normalCells = 0
    bombs = 0

    fd = newSeq[CellKind](fw * fh)

    for i in countdown(fw * fh-1, 0):
      fd[i].flags = if random(15) < 3: { ckHIDDEN, ckBOMB } else: { ckHIDDEN }

    normalCells = 0;
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

  createField()

  dump()

  let mainFrame = wxFrame(title="Nim Bombs!",
    stl = wxDEFAULT_DIALOG_STYLE or wxMINIMIZE_BOX)

  let bmp = wxBitmapFromXPM(addr icon_data[0])

  #let icon = wxIconFromXPM(addr icon_data[0])
  #wxIcon_CopyFromBitmap(icon, bmp)
  #wxTopLevelWindow_SetIcon(mainFrame, icon);

  let sizer = wxBoxSizer(wxVertical)
  let button = wxBitmapButton(mainFrame, wxID_ANY, bmp, 0, 0, -1, -1, wxBORDER_NONE)

  mainFrame.connect(expEVT_COMMAND_BUTTON_CLICKED()) do(evn: WxEvent):
    #wxnExitMainLoop()
    createField()
    #mainFrame.setSize(0, 0, 600, 600, wxSIZE_AUTO)
    panel.fit()
    panel.refresh()

  let status = mainFrame.createStatusBar(3)

  proc updateStatus() =
    status.setStatusText("Bombs: " & $bombs, 0)
    status.setStatusText("Cells: " & $normalCells, 1)
    status.setStatusText("Level: " & $level, 2)

  updateStatus()

  mainFrame.setSizer(sizer)
  panel = wxPanel(mainFrame, wxID_ANY, 0,0, (fw * UNIT), fh * UNIT, wxBORDER_NONE)

  sizer.addWindow(panel, 1, wxALL, 10)
  sizer.addWindow(button, 0, wxALL, 10)

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
          echo "BOOM"
          cell(x, y).flags.incl( ckEXPLODED )
          normalCells = 0
          updateStatus()
          uncoverAll()
          wxnBell() # whatever sound it makes
          return

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
          createField()
          panel.refresh()

  # uncover a field
  panel.connect(expEVT_LEFT_DOWN()) do(evn: WxEvent):
    let evn = WxMouseEvent(evn)
    if normalCells == 0:
      return
    let x = evn.getX() div UNIT
    let y = evn.getY() div UNIT
    uncover(x,y)
    panel.refresh()

  # add a "Marker"
  panel.connect(expEVT_RIGHT_DOWN()) do(evn: WxEvent):
    let evn = WxMouseEvent(evn)
    if normalCells == 0:
      return
    let x = evn.getX() div UNIT
    let y = evn.getY() div UNIT

    let flags = cell(x, y).flags
    if ckHIDDEN in flags:
      if ckMARK in flags:
        cell(x, y).flags.excl(ckMARK)
      else:
        cell(x, y).flags.incl(ckMARK)
      panel.refresh()

  ## Paint the playfield
  panel.connect(expEVT_PAINT()) do(evn: WxEvent):
    let brushGrey {.global.} = wxBrush(wxColourRGB(150,150,150))
    #let brushGrey = wxGreyBrush()
    #let brushWhite {.global.} = wxBrush(wxColourRGB(255,255,255))
    let brushWhite {.global.} = wxWhiteBrush()
    let brushRed {.global.} = wxRedBrush()

    let dc = wxPaintDC(panel) # PaintDC because we are in PaintEvent

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
        dc.drawRectangle(x * UNIT, y * UNIT, UNIT-1, UNIT-1)

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
        else:
          txt = "?"

        if ckEXPLODED in flags:
          cross = wxPen(0,0,255)

        let (w,h,_,_) = dc.getTextExtent(txt)
        dc.setTextForeground(col)
        dc.drawText(txt, x * UNIT + (UNIT - w) div 2 , y * UNIT + (UNIT - h) div 2)

        if cross != nil:
          dc.setPen(cross)
          dc.drawLine(x * UNIT, y * UNIT, x * UNIT + UNIT - 1, y * UNIT + UNIT - 1 )
          dc.drawLine(x * UNIT, y * UNIT + UNIT - 1, x * UNIT + UNIT - 1, y * UNIT )
          cross.delete # pen is not consumed

        col.delete # colors are not consumed
    # we need to delete it (if not we get drawing artefacts)
    dc.delete

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain
  # ... Mainloop running here ...
  echo "Done"
