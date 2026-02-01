import os

proc whatos*(args: seq[string]) {.exportc.} =
  echo readFile("/proc/version")
