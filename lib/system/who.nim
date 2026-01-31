import os
proc who*(args: seq[string]) {.exportc.} =
  when defined(windows):
    let user = getEnv("USERNAME")
  else:
    let user = getEnv("USER")

  echo user
