import strformat, os, strutils

proc up*(args: seq[string]) {.exportc.} =
  let text = readFile("/proc/uptime")
  let parts = text.split(' ')
  let uptime = parseFloat(parts[0])
  echo uptime
