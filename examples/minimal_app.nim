import wxcnim

proc mainApp() =
  echo "Enter mainLoop"
  # we need at least one frame such that the app closes correctly!
  discard wxFrame(title="Guess my title") # discard ...
  let wn = wxnGetTopWindow() # refind
  echo "Found Title: ", wn.getLabel() # prove its the right one
  wn.close() # close (which will exit the app)
  echo "Leave mainLoop"

wxnRunMainLoop mainApp
echo "Exit App"
