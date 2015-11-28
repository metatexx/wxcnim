import streams

let fh = open("/etc/hosts")
var buf = newString(100)
discard readBuffer(fh, cast[pointer](addr buf[0]), 10)
echo buf

let fs = newFileStream("/etc/hosts", fmRead)
let s = fs.readStr(10)
echo s

let fh2 = open("/etc/hosts")
var s2 = ""
for i in 0..9:
  s2.add readChar(fh2)
echo s2
