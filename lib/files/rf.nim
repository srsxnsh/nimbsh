import os

proc rf*(args: seq[string]) {.exportc.} =
  if args.len == 0:
    echo "read what?"
    return
  let path = args[0]
  if fileExists(path):
    let content = readFile(path)
    echo content
  else:
    echo "cant find that one"
    return
