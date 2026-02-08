import std/posix, std/tables, std/sequtils
from ./tokenizer import Token, tokenize, TokenKind

proc execpipe*(cmdSeq: seq[seq[Token]], builtins: Table[string, proc(args: seq[string])]) =
  let numCmds = cmdSeq.len
  var pipes: seq[array[2, cint]] = @[]
  
  for i in 0..<(numCmds - 1):
    var p: array[2, cint]
    if pipe(p) != 0:
      stderr.writeLine("pipe creation failed")
      return
    pipes.add(p)
  
  #-------------------execute order 66 type shi
  var pids: seq[Pid] = @[]
  
  for i in 0..<numCmds:
    let pid = fork()
    if pid == 0:
      # Child process
      
      #-----------------NOT FIRST
      if i > 0:
        discard dup2(pipes[i-1][0], STDIN_FILENO)
      
      # -------------------NOT LAST
      if i < numCmds - 1:
        discard dup2(pipes[i][1], STDOUT_FILENO)
      
      # close pipes
      for p in pipes:
        discard close(p[0])
        discard close(p[1])
      
      # EXECUTE!!!!!!!!!!!!!!!!!!!
      let cmd = cmdSeq[i][0].value
      let args = if cmdSeq[i].len > 1:
        cmdSeq[i][1..^1].mapIt(it.value) else: @[]
      
      let argv = allocCStringArray(@[cmd] & args)
      discard execvp(cmd.cstring, argv)
      stderr.writeLine("command not found: " & cmd)
      quit(127)
    else:
      pids.add(pid)
  
  # closem 
  for p in pipes:
    discard close(p[0])
    discard close(p[1])
  
  for pid in pids:
    var status: cint
    discard waitpid(pid, status, 0)
