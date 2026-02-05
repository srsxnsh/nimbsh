import std/os

proc go*(args: seq[string]) {.exportc.} =
  if args.len == 0:
    echo "...go where?"
    return
  try:
    setCurrentDir(args[0])
  except OSError as e:
    echo "Error: ", e.msg


