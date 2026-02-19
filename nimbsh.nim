import std/os, std/tables, std/strutils, std/posix, std/sequtils

# a coupla tables 

var shellVars = initTable[string, string]()
var commands = initTable[string, proc(args: seq[string])]()

#-------------------------------------------IMPORT UTILITIES

from utils/execcmd import execcmd
from utils/tokenizer import Token, tokenize, TokenKind
from utils/execpipe import execpipe
from utils/vars import isAssignment, parseAssignment, expand

#-----------------------------------IMPORT COMMANDS 

# core library
import lib/core/echo; commands["echo"] = echo.echo
import lib/core/go; commands["cd"] = go.go
import lib/core/exit; commands["exit"] = exit.exit

# extra library
import lib/extra/nimbsh; commands["nimbsh"] = nimbsh.nimbsh
import lib/extra/spam; commands["spam"] = spam.spam

# process library - coming soon ig? with like, bging and fging procs 

#----------------------------------------------STARTUP STUFF

echo ""
echo "nimbsh v1.0.0"
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

  if isAssignment(tokens):
    let (varName, varValue) = parseAssignment(tokens)
    if varName.len > 0:
      # Expand variables in the value before storing
      shellVars[varName] = expand(varValue, shellVars)
    continue
  
  # expand all variables in the tokens 
  var expandedTokens = tokens
  for i in 0..<expandedTokens.len:
    expandedTokens[i].value = expand(expandedTokens[i].value, shellVars)

  
  var commands_seq: seq[seq[Token]] = @[@[]]
  for token in expandedTokens:
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
