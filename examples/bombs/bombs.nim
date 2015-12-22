# Simple version of Minesweeper
#
# This is still WIP!
#
# Todos:
#  Fix first click behavior (no bomb!)
#  Make different level (sizes)
#  Add the graphics
#  Add sound
#  Better data structure!

import wxcnim

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

type
  FieldObj = object
    level: int
    w, h: int
    normalCells, bombs: int
    fieldData: seq[CellKind]
  Field = ref FieldObj

proc cell(fd: Field, x, y: int): var CellKind =
  fd.fieldData[y * fd.w + x]

proc createField(w,h : int): Field =
  result = new FieldObj
  result.level = 1
  result.normalCells = 0
  result.bombs = 0
  result.w = w
  result.h = h

  var fd = newSeq[CellKind](w * h)
  #fd.shallow() # xxx will araq freak out?
  #result.fieldData = fd
  shallowCopy(result.fieldData, fd)

  for i in countdown(w * h-1, 0):
    fd[i].flags = if random(15) < 3: { ckHIDDEN, ckBOMB } else: { ckHIDDEN }

  result.normalCells = 0;
  for x in 0 ..< w:
    for y in 0 ..< h:
      if ckBOMB notin result.cell(x, y).flags:
        inc result.normalCells
        for xx in -1 .. 1:
          for yy in -1 .. 1:
            if (xx != 0 or yy != 0) and
              x + xx >= 0 and
              x + xx < w and
              y + yy >= 0 and
              y + yy < h and
              ckBOMB in result.cell(x + xx, y + yy).flags:
                inc fd[y * w + x].count

  result.bombs = w * h - result.normalCells;

proc dump(f: Field) =
  for y in 0 ..< f.w:
    var row = ""
    for x in 0 ..< f.h:
      if ckBOMB in f.cell(x, y).flags:
        row &= "*"
      else:
        row &= $f.cell(x, y).count
    echo row

proc updateStatus(status: WxStatusBar, f: Field) =
  # xxx triggered closure bug if used inside appMain
  #let status = mainFrame.getStatusBar
  status.setStatusText("Bombs: " & $f.bombs, 0)
  status.setStatusText("Cells: " & $f.normalCells, 1)
  status.setStatusText("Level: " & $f.level, 2)

proc appMain() =
  wxnInitAllImageHandlers()

  var f = createField(10,10)

  dump f

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
    f = createField(10, 10)
    #mainFrame.setSize(0, 0, 600, 600, wxSIZE_AUTO)
    panel.fit()
    panel.refresh()

  let status = mainFrame.createStatusBar(3, wxSTB_SIZEGRIP)
  #mainFrame.wxFrame_SetStatusBar(status)
  #var fields = [100,-1]
  #wxFrame_SetStatusWidths(status, 2, addr(fields[0]))

  updateStatus(status, f)

  mainFrame.setSizer(sizer)
  panel = wxPanel(mainFrame, wxID_ANY, 0,0, (f.w * UNIT), f.h * UNIT, wxBORDER_NONE)

  sizer.addWindow(panel, 1, wxALL, 10)
  sizer.addWindow(button, 0, wxALL, 10)

  proc uncoverAll() =
    for f in mitems(f.fieldData):
      f.flags.excl(ckHIDDEN)
    panel.refresh()

  proc uncover(x, y: int) =
    if x >= 0 and x < f.w and y >= 0 and y < f.h:
      var (flags, count) = f.cell(x, y)
      # not marked? and hidden?
      if ckMARK notin flags and ckHIDDEN in flags:
        # wft.. boom!
        if ckBOMB in flags:
          echo "BOOM"
          f.cell(x, y).flags.incl( ckEXPLODED )
          f.normalCells = 0
          updateStatus(status, f)
          uncoverAll()
          return

        # uncover field
        flags.excl( ckHIDDEN )
        # update cell
        f.cell(x, y).flags = flags

        if flags == {} and count == 0:
            for xx in -1 .. 1:
              for yy in -1 .. 1:
                if xx != 0 or yy != 0:
                  uncover(x + xx, y + yy)

        dec f.normal_cells;
        updateStatus(status, f)
        if f.normal_cells == 0:
          uncoverAll()
          let msgDlg = wxMessageDialog_Create(
            panel,
            "You have found all the bombs!",
            "wxNimBombs",
            wxOK)# or wxICON_INFORMATION)
          discard msgDlg.showModal()
          f = createField(10, 10)
          panel.refresh()

  panel.connect(expEVT_LEFT_DOWN()) do(evn: WxMouseEvent):
    if f.normalCells == 0:
      return
    let x = evn.getX() div UNIT
    let y = evn.getY() div UNIT
    uncover(x,y)
    panel.refresh()

  panel.connect(expEVT_RIGHT_DOWN()) do(evn: WxMouseEvent):
    if f.normalCells == 0:
      return
    let x = evn.getX() div UNIT
    let y = evn.getY() div UNIT

    let flags = f.cell(x, y).flags
    if ckHIDDEN in flags:
      if ckMARK in flags:
        f.cell(x, y).flags.excl(ckMARK)
      else:
        f.cell(x, y).flags.incl(ckMARK)
      panel.refresh()

  panel.connect(expEVT_PAINT()) do(evn: WxEvent):
    let brushGrey {.global.} = wxBrush(wxColourRGB(150,150,150))
    #let brushGrey = wxGreyBrush()
    #let brushWhite {.global.} = wxBrush(wxColourRGB(255,255,255))
    let brushWhite = wxWhiteBrush()
    let brushRed = wxRedBrush()

    let dc = wxPaintDC(panel) # PaintDC because we are in PaintEvent

    for x in 0 ..< f.w:
      for y in 0 ..< f.h:
        let (flags, count) = f.cell(x, y)
        dc.setPen(wxBlackPen())
        #dc.drawRectangle(x * UNIT + UNIT - 1, y * UNIT, 1, UNIT )
        if (ckHIDDEN in flags) or (ckMARK in flags):
          dc.setBrush(brushGrey)
        elif ckBOMB in flags:
          dc.setBrush(brushRed)
        else:
          dc.setBrush(brushWhite)

        dc.drawRectangle(x * UNIT, y * UNIT, UNIT-1, UNIT-1)

        var txt: WxString
        var col: WxColour = wxColourRGB(0,0,0)
        var cross: WxPen = nil

        if ckMARK in flags:
          txt = "M"
          col = wxColourRGB(255,0,0)
          if ckBOMB in flags and ckHIDDEN notin flags:
            col = wxColourRGB(0,0,255)
            cross = wxBlackPen()
        elif ckHIDDEN notin flags:
          if ckBOMB in flags:
            txt = "B"
          else:
            txt = $count
            col = case count:
              of 0: wxColourRGB(0,180,0)
              of 1: wxColourRGB(0,0,255)
              else: wxColourRGB(0,0,0)
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

    # we need to delete it (if not we get drawing artefacts)
    dc.delete()

  mainFrame.fit
  mainFrame.show
  mainFrame.`raise` # do I want mainFrame.raize?

when isMainModule:
  # Initialising and running "appMain"
  wxnRunMainLoop appMain
  # ... Mainloop running here ...
  echo "Done"
