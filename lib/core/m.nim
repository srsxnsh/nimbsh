import os

proc m*(args: seq[string]) {.exportc.} =
  if args.len == 0:
    echo "Make what?"
    return

  let path = args[0]

  if fileExists(path):
    echo "File already exists bro"
  else:
    writeFile(path, "")
    echo "Made file:", path

