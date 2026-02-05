import std/os, std/tables, std/strutils, std/posix, std/sequtils

#-------------------------------------------exec and tokenize
proc execcmd(cmd: string, args: seq[string]) =
  let pid = fork()

  if pid == 0:
    
    let argv = allocCStringArray(@[cmd] & args)
    discard execvp(cmd.cstring, argv)

    
    stderr.writeLine("command not found: " & cmd)
    quit(127)
  else:
    
    var status: cint
    discard waitpid(pid, status, 0)

from utils/tokenizer import Token, tokenize, TokenKind





#-----------------------------------IMPORTING COMMANDS 
# setup
var commands = initTable[string, proc(args: seq[string])]()

# core library
import lib/core/echo; commands["echo"] = echo.echo
import lib/core/go; commands["go"] = go.go
import lib/core/exit; commands["exit"] = exit.exit

# extra library
import lib/extra/nimbsh; commands["nimbsh"] = nimbsh.nimbsh
import lib/extra/spam; commands["spam"] = spam.spam

# process library


echo ""
echo "nimbsh v0.0.0"
var pointer : string = " »» "

#---------------------------------------------MAIN LOOP
while true:
  echo ""
  stdout.write(getCurrentDir() & pointer)
  let line = stdin.readLine().strip
  if line.len == 0: continue

  # parse
  let tokens = tokenize(line)
  if tokens.len == 0: continue
  let cmd = tokens[0].value

  let args = if tokens.len > 1: 
    tokens[1..^1].mapIt(it.value) else: @[]

  
  if commands.hasKey(cmd):
    commands[cmd](args)
  else:
    execcmd(cmd, args)

