import std/os, std/tables, std/posix, std/strutils

from ./tokenizer import Token, tokenize, TokenKind

proc isAssignment*(tokens: seq[Token]): bool =
  #uhh lowkirkenuinely is a variable being assigned at this point in time 
  if tokens.len == 0: return false
  let first = tokens[0].value
  return '=' in first and not first.startsWith('=')

proc parseAssignment*(tokens: seq[Token]): (string, string) =
  # parse VAR=val
  let first = tokens[0].value
  let parts = first.split('=', maxsplit=1)
  if parts.len == 2:
    return (parts[0], parts[1])
  return ("", "")

proc expand*(value: string, vars: Table[string, string]): string =
  var result = ""
  var i = 0
  while i < value.len:
    if value[i] == '$' and i + 1 < value.len:
      inc i
      var varName = ""

      while i  < value.len and (value[i].isAlphaNumeric or value[i] == '_'):
        varName.add value[i]
        inc i

      if vars.hasKey(varName):
        result.add vars[varName]
      elif existsEnv(varName):
        result.add getEnv(varName)
    else: 
      result.add value[i]
      inc i

  return result

