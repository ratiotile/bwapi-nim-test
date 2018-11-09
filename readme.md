Basic C++ static library usage in Nim.

I installed c2nim using nimble: `nimble install c2nim`

Then I ran c2nim on the BWAPI header:

`c2nim --cpp --header bwapi\include\BWAPI.h -o:BWAPI.nim`

I had to modify Sublime's build command for 32-bit mode:

```
{
    "shell_cmd": "\"c:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\vc\\vcvarsall.bat\" x86 && nim cpp --cpu:i386 $file_base_name"
}
```

compile on the command line with `nim cpp main.nim`

32-bit Nim is needed to compile 32-bit programs.

# Problems

## nim passes arguments to vcc linker incorrectly
Nim does this, given the passL config setting:
`# cl.exe ${passL} ${libs} /nologo /DEBUG /Zi /F33554432 /Fe${output} ${objs}`

The linker options must appear after the output filename, and have [`/link` ](https://docs.microsoft.com/en-us/cpp/build/reference/link-pass-options-to-linker?view=vs-2017) prepended. This is how it should work:
`# cl.exe ${libs} /nologo /DEBUG /Zi /F33554432 /Fe${output} /link ${passL} ${objs}`


## c2nim has trouble with templates:

### c++11 override
    client\bulletimpl.h(19, 41) Error: ';' expected
    client\forceimpl.h(15, 41) Error: ';' expected
    client\gameimpl.h(81, 57) Error: ';' expected
    client\playerimpl.h(22, 41) Error: ';' expected
    client\regionimpl.h(20, 39) Error: ';' expected
    client\unitimpl.h(30, 51) Error: ';' expected

### operator << (can ignore?)
    color.h(219, 61) Error: ')' expected

### templates with more than one T parameter
    bestfilter.h(16, 41) Error: '> [end of template]' expected
    filters.h(22, 45) Error: '> [end of template]' expected
    position.h(11, 38) Error: '> [end of template]' expected
    unaryfilter.h(22, 72) Error: '> [end of template]' expected

### Lambda
    comparisonfilter.h(13, 50) Error: did not expect [
    
### C++11 deleted functions (ignore?)
    game.h(52, 48) Error: '[integer literal]' expected

### Skip private/protected inline functions
    Type.h(40, 33) Error: ')' expected
    Interface.h(30, 15) Error: identifier expected, but found '= (pxAsgn)'

### default operator=
    SetContainer.h(25, 61) Error: '[integer literal]' expected

### Partial Template Specialization
    Position.h(15, 36) Error: ';' expected

### Template function type in constructor
    InterfaceEvent.h(37, 49) Error: '> [end of template]' expected
