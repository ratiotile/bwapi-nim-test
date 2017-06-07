import ospaths, re, strutils
let files = [
  "bwapi/include/bwapi/CoordinateType.h".unixToNativePath,
  "bwapi/include/bwapi/EventType.h".unixToNativePath,
  "bwapi/include/bwapi/Flag.h".unixToNativePath,
  "bwapi/include/bwapi/Input.h".unixToNativePath,
  "bwapi/include/bwapi/Latency.h".unixToNativePath,
  "bwapi/include/bwapi/TournamentAction.h".unixToNativePath,
  "bwapi/include/bwapi/Color.h".unixToNativePath,
]
let re_namespace = re"namespace\s*(\w+)(?:$|\s)?"
# ignore forward declarations
let re_class = re"class\s*(\w+)(?![^;])$"
let re_enum = re"enum\s*(\w+)(?![^;])$"
let re_open_braces = re"{"
let re_close_braces = re"}"

var current_brace_level = 0
type
  ContextTracker = object
    stack: seq[string]
    brace_level: seq[int]

proc push(ct:var ContextTracker, name:string)=
  ct.stack.add(name)
  ct.brace_level.add(current_brace_level)

proc closeBrace(ct:var ContextTracker, level:int)=
  if ct.stack.len == 0:
    return
  let top = ct.brace_level[^1]
  if level <= top:
    discard ct.stack.pop()
    discard ct.brace_level.pop()

proc print(self: ContextTracker):string=
  result = self.stack.join("_")

var namespace = ContextTracker(stack: @[], brace_level: @[])
var class = ContextTracker(stack: @[], brace_level: @[])

proc openBrace()=
  inc current_brace_level

proc closeBrace()=
  dec current_brace_level
  namespace.closeBrace(current_brace_level)
  class.closeBrace(current_brace_level)

iterator enumParser(line:string): string {.closure.} =
  var body:seq[string]
  body = @["{"]
  var matches: array[10, string]
  while line.find(re_open_braces, matches) == -1:
    yield ""
  while true:
    var stripped = strip(line)
    if stripped.startsWith("//"):
      yield ""
      continue
    if stripped.endsWith(","):
      body.add(stripped)
    if stripped.find(re_close_braces, matches) > -1:
      var output = body.join("\n  ")&"\n};"
      yield output
      return
    yield ""

iterator parser2(line:string): string {.closure.} =
  var matches: array[10, string]
  while true:
    if(line.find(re_namespace, matches) > -1):
      namespace.push(matches[0])
    if line.find(re_enum, matches) > -1:
      yield namespace.print()&"_" & matches[0]
      var enum_iter = enumParser
      while true:
        var e = enum_iter(line)
        if e != "":
          yield e
          break
        yield ""
    for brace in line.findAll(re_open_braces):
      openBrace()

    for brace in line.findAll(re_close_braces):
      closeBrace()
    yield ""


var parse_line = parser2
for file in files:
  echo "//File: " & file
  for line in lines file:
    var pl = parse_line(line)
    if pl != "":
      echo pl

