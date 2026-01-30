import os

proc md*(args: seq[string]) {.exportc.} =
  if args.len == 0:
    echo "Make what dir?"
    return

  let path = args[0]

  if existsDir(path):
    echo "Dir already exists bro"
  else:
    createDir(path)
    echo "Made dir:", path

