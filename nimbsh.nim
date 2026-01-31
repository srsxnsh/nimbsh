import std/os, std/tables, std/strutils

#-----------------------------------IMPORTING COMMANDS 
# setup
var commands = initTable[string, proc(args: seq[string])]()

# core library
import lib/core/echo; commands["echo"] = echo.echo
import lib/core/go; commands["go"] = go.go
import lib/core/exit; commands["exit"] = exit.exit
import lib/core/m; commands["m"] = m.m
import lib/core/r; commands["r"] = r.r
import lib/core/md; commands["md"] = md.md
import lib/core/l; commands["l"] = l.l

# extra library

# files library
import lib/files/rf; commands["rf"] = rf.rf


#---------------------------------------------- 
echo ""
echo "nmbsh v0.0.0"
var pointer : string = " »» "

#---------------------------------------------MAIN LOOP
while true:
  let dir = getCurrentDir()
  echo ""
  stdout.write(dir & pointer)
  let line = stdin.readLine().strip
  if line.len == 0: continue

  # parse
  let parts = line.split(" ")
  let cmd = parts[0]
  let args = if parts.len > 1: parts[1..^1] else: @[]

  
  if commands.hasKey(cmd):
    commands[cmd](args)
  else:
    echo "Command not found: ", cmd

