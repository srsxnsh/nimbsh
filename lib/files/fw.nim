import os

proc fw*(args: seq[string]) {.exportc.} =
  if args.len == 0:
    echo "write what to what?"
    return

  elif args.len == 1:
    echo "write to what?"
    return

  let content = args[0]
  let path = args[1]
  if fileExists(path):
    writeFile(path, content)
  else:
    echo "cant find that one"
    return
