import os

proc l*(args: seq[string]) {.exportc.} =
  let dir = if args.len > 0: args[0] else: "."

  if not dirExists(dir):
    echo "cant find direcctory: ", dir
    return

  for kind, path in walkDir(dir, relative=true):
    case kind
    of pcFile: echo path
    of pcDir:  echo path & "/"
    else: discard

