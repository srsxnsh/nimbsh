import terminal

proc spam*(args: seq[string]) {.exportc.} =
  
  var spammer : string = "nimbsh!!!"
  if not args.len == 0:
    spammer = args[0]

  while true:
    echo spammer
  
