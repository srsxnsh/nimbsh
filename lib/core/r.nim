import os, std/strutils

proc r*(args: seq[string]) =
  if args.len == 0:
    echo "Remove what?"
    return
  let path = args[0]

  if fileExists(path):

    if path == "/" or path == "/dev":
      stdout.write("Are you sure you want to remove that bro? [yes]")
      if not (stdin.readLine().strip == "yes"):
        echo "Aborted."
        return


    removeFile(path)
    echo "Removed", path
  else:
    echo "Cant find that one"
