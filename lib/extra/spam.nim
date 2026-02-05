proc spam*(args: seq[string]) {.exportc.} =

  var spammer : string = "yo"
  if args.len != 0:
    spammer = args[0]
  else: spammer = "nimbsh!!!"

  while true:
    echo spammer
  
