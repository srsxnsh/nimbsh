import std/posix

proc execcmd*(cmd: string, args: seq[string]) =
  let pid = fork()

  if pid == 0:
    
    let argv = allocCStringArray(@[cmd] & args)
    discard execvp(cmd.cstring, argv)

    
    stderr.writeLine("command not found: " & cmd)
    quit(127)
  else:
    
    var status: cint
    discard waitpid(pid, status, 0)

