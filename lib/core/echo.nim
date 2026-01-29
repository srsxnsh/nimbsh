import std/strutils 

proc echo*(args: seq[string]) {.exportc.} =
  echo args.join(" ")

