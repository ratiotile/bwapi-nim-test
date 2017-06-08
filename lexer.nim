## Produces tokens from a C++ header line
import strutils, re

# assume we know the line starts with a word
proc consumeWord(line:var string) : string =
  let (_, last) = line.findBounds(re"(\w+)")
  result = line[0..last]
  line = line[last+1..^0]

proc consumeCharacter(line:var string) : string =
  result = line[0..0]
  line = line[1..^0]
  #echo("consumed char: '" & result & "' remain: " & line)

proc consumeTwo(line:var string) : string =
  result = line[0..1]
  line = line[2..^0]

proc consumeThree(line:var string) : string =
  result = line[0..2]
  line = line[3..^0]

proc consumeTemplate(line:var string) =
  var open = 0
  for i in 0..line.len()-1:
    case line[i]:
      of '<':
        inc open
      of '>':
        dec open
        if open == 0:
          #echo "//ignore template: " & line[0..i]
          line = line[i+1..^0]
          return
      else:
        continue

proc consumeString(line:var string) : string =
  let (_, last) = line.findBounds(re("\"[^\"]*\""))
  result = line[0..last]
  line = line[last+1..^0]

proc lineLexer(line:string): iterator(): string =
  return iterator(): string =
    var remaining = strip(line)
    while remaining.len() > 0:
      if remaining.startswith(re"\s"):
        remaining = strip(remaining)
        continue
      elif remaining.startswith(re"\w"):
        yield consumeWord(remaining)
      elif remaining.startswith(re"::"):
        yield consumeTwo(remaining)
      elif remaining.startswith(re"&&"):
        yield consumeTwo(remaining)
      # stream operator <<
      elif remaining.startswith(re"<<[^>]*$"):
        yield consumeTwo(remaining)
      elif remaining.startswith(re"<"):
        consumeTemplate(remaining)
        continue
      elif remaining.startswith(re"->"):
        yield consumeTwo(remaining)
      elif remaining.startswith(re"//"):
        return
      elif remaining.startswith(re"\#"):
        return
      # destructor
      elif remaining.startswith(re"~"):
        return
      elif remaining.startswith(re"\.\.\."):
        yield consumeThree(remaining)
      elif remaining.startswith(re("\"")):
        yield consumeString(remaining)
      elif remaining.startswith(re":|{|}|\(|\)|;|=|,|&|\*"):
        yield consumeCharacter(remaining)
      else:
        echo "Error: unknown string: " & remaining
        return


when isMainModule:
  import ospaths
  for line in lines "bwapi/include/bwapi/position.h".unixToNativePath:
    #let line = "static_assert(sizeof(Color) == sizeof(int),\"Expected type to resolve to primitive size.\");"
    var lexer = lineLexer(line)
    while true:
      let word = lexer()
      if not finished(lexer):
        echo word
      else:
        break
