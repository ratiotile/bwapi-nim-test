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
