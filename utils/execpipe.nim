import std/os, std/posix, std/tables, std/strutils, std/sequtils
from ./tokenizer import Token, tokenize, TokenKind

proc execpipe*(cmdSeq: seq[seq[Token]], builtins: Table[string, proc(args: seq[string])]) =
  let numCmds = cmdSeq.len
  var pipes: seq[array[2, cint]] = @[]
  
  # Create all pipes needed (n-1 pipes for n commands)
  for i in 0..<(numCmds - 1):
    var p: array[2, cint]
    if pipe(p) != 0:
      stderr.writeLine("pipe creation failed")
      return
    pipes.add(p)
  
  # Fork and execute each command
  var pids: seq[Pid] = @[]
  
  for i in 0..<numCmds:
    let pid = fork()
    if pid == 0:
      # Child process
      
      # If not first command, read from previous pipe
      if i > 0:
        discard dup2(pipes[i-1][0], STDIN_FILENO)
      
      # If not last command, write to next pipe
      if i < numCmds - 1:
        discard dup2(pipes[i][1], STDOUT_FILENO)
      
      # Close all pipe file descriptors in child
      for p in pipes:
        discard close(p[0])
        discard close(p[1])
      
      # Execute the command
      let cmd = cmdSeq[i][0].value
      let args = if cmdSeq[i].len > 1:
        cmdSeq[i][1..^1].mapIt(it.value) else: @[]
      
      # Built-ins won't work properly in child process for pipes
      # So we just exec everything
      let argv = allocCStringArray(@[cmd] & args)
      discard execvp(cmd.cstring, argv)
      stderr.writeLine("command not found: " & cmd)
      quit(127)
    else:
      pids.add(pid)
  
  # Parent process: close all pipes
  for p in pipes:
    discard close(p[0])
    discard close(p[1])
  
  # Wait for all children
  for pid in pids:
    var status: cint
    discard waitpid(pid, status, 0)
