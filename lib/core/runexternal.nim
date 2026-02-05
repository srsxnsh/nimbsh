import posix, os

proc runexternal(cmd: string, args: seq[string]) =
  let pid = fork()

  if pid == 0:
    
    var argv = @[cmd]
    argv.add(args)
    execvp(cmd, argv)
    
    stderr.writeLine("command not found: " & cmd)
    quit(127)
  else:
    
    var status: cint
    discard waitpid(pid, status, 0)

