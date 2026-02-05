type
  TokenKind* = enum
    tkWord, tkString, tkPipe, tkNewline, tkEOF
  Token* = object
    kind*: TokenKind
    value*: string

proc tokenize*(input: string): seq[Token] =
  var result: seq[Token] = @[]
  var i = 0
  while i < input.len:
    let c = input[i]
    case c
    of ' ', '\t':
      inc i
    of '|':
      result.add Token(kind: tkPipe, value: "|")
      inc i
    of '"':
      # parse double-quoted string
      inc i
      var str = ""
      while i < input.len and input[i] != '"':
        str.add input[i]
        inc i
      if i < input.len: inc i  # skip closing quote
      result.add Token(kind: tkString, value: str)
    of '\'':
      # parse single-quoted string
      inc i
      var str = ""
      while i < input.len and input[i] != '\'':
        str.add input[i]
        inc i
      if i < input.len: inc i  # skip closing quote
      result.add Token(kind: tkString, value: str)
    of '#':
      break # comment
    else:
      # parse word
      var word = ""
      while i < input.len and input[i] notin {' ', '\t', '|', '"', '\'', '#'}:
        word.add input[i]
        inc i
      if word.len > 0:
        result.add Token(kind: tkWord, value: word)
  return result
