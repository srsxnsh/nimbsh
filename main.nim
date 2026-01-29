import std/os, std/tables, std/strutils

#-----------------------------------IMPORTING COMMANDS 
# setup
var commands = initTable[string, proc(args: seq[string])]()

# core library
import lib/core/echo; commands["echo"] = echo.echo
import lib/core/go; commands["go"] = go.go
import lib/core/exit; commands["exit"] = exit.exit

#---------------------------------------------- 



#---------------------------------------------MAIN LOOP
while true:
  let dir = getCurrentDir()
  stdout.write(dir & " »» ")
  let line = stdin.readLine().strip
  if line.len == 0: continue

  let parts = line.split(" ")
  let cmd = parts[0]
  let args = if parts.len > 1: parts[1..^1] else: @[]

  if commands.hasKey(cmd):
    commands[cmd](args)
  else:
    echo "Command not found: ", cmd

