import ospaths, re, strutils

let file = "bwapi/include/bwapi/EventType.h".unixToNativePath

echo file

var current_brace_level = 0

type
  ContextTracker = object
    stack: seq[string] not nil
    brace_level: seq[int] not nil

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

proc newContextTracker(): ContextTracker =
  result = ContextTracker(stack: @[], brace_level: @[])



var namespace = newContextTracker()
var class = newContextTracker()

proc openBrace(level:var int)=
  inc level

proc closeBrace(level:var int)=
  dec level
  namespace.closeBrace(level)
  class.closeBrace(level)



var re_namespace = re"namespace\s*(\w+)(?:$|\s)?"
# ignore forward declarations
var re_class = re"class\s*(\w+)(?![^;])$"
var re_enum = re"enum\s*(\w+)(?![^;])$"
var re_open_braces = re"{"
var re_close_braces = re"}"

var matches: array[10, string]


echo "namespace BWAPI".find(re_namespace)

for line in lines file:
  var ln:string = line
  if(ln.find(re_namespace, matches) > -1):
    namespace.push(matches[0])
    echo namespace.print()
  elif(ln.find(re_class, matches) > -1):
    class.push(matches[0])
    echo namespace.stack.join("_") & class.stack.join("_")
  elif(ln.find(re_enum, matches) > -1):
    let enum_name = matches[0]
    echo "enum "&namespace.print()&"_"&enum_name
    echo "{"
    echo "};"

  for ob in ln.findAll(re_open_braces):
    current_brace_level.openBrace()

  for ob in ln.findAll(re_close_braces):
    current_brace_level.closeBrace()


