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

# Problems

## c2nim has trouble with templates:

    
    
    
    
    
    
    
    

### explicit default constructor
    event.h(17, 16) Error: ';' expected
    interface.h(19, 18) Error: ';' expected
    interfaceevent.h(18, 23) Error: ';' expected
    unitcommand.h(18, 22) Error: ';' expected

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
    setcontainer.h(17, 51) Error: '> [end of template]' expected
    type.h(13, 35) Error: '> [end of template]' expected
    unaryfilter.h(22, 72) Error: '> [end of template]' expected

### Lambda
    comparisonfilter.h(13, 50) Error: did not expect [
    
### C++11 deleted functions (ignore?)
    game.h(52, 48) Error: '[integer literal]' expected
    
