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
from utils/execpipe import execpipe





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
  

  var line = ""
  var continuation = false
  while true:
    if continuation:
      stdout.write("> ") 
    let inputLine = stdin.readLine()
    
    if inputLine.endsWith("\\"):
      line.add inputLine[0..^2]  
      line.add " " 
      continuation = true
    else:
      line.add inputLine
      break
  
  line = line.strip
  if line.len == 0: continue
  
  # parse tokenizer
  let tokens = tokenize(line)
  if tokens.len == 0: continue
  
  var commands_seq: seq[seq[Token]] = @[@[]]
  for token in tokens:
    if token.kind == tkPipe:
      commands_seq.add(@[])
    else:
      commands_seq[^1].add(token)
  
  # no more empties that break pipes grr 
  commands_seq = commands_seq.filterIt(it.len > 0)
  
  if commands_seq.len == 0: continue
  
  # nuh uh zero pipes to be seen here
  if commands_seq.len == 1:
    let cmd = commands_seq[0][0].value
    let args = if commands_seq[0].len > 1: 
      commands_seq[0][1..^1].mapIt(it.value) else: @[]
    
    if commands.hasKey(cmd):
      commands[cmd](args)
    else:
      execcmd(cmd, args)
  else:
    # ah fuck there are pipes
    execpipe(commands_seq, commands)
