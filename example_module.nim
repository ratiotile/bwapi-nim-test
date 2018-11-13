import winlean
import nim_bwapi/BWAPI/Game
import nim_bwapi/BWAPI/AIModule

type
  ExampleModule {.importcpp:"ExampleAIModule", header:"ExampleAIModule.h".} = object of AIModule

proc setOnStartCallback(this: ExampleModule, cb: proc(){.cdecl.})
  {.importcpp: "setOnStartCallback", header: "ExampleAIModule.h"}

const DLL_PROCESS_ATTACH = 1
const DLL_PROCESS_DETACH = 0

# extern "C" __declspec(dllexport) void gameInit(BWAPI::Game* game) { BWAPI::BroodwarPtr = game; }
proc gameInit(game: ptr Game) {.cdecl,exportc,dynlib.} =
  BroodwarPtr = game

# BOOL __stdcall DllMain(HANDLE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
proc DLLMain(hModule: Handle, ul_reason_for_call: Dword, lpReserved: pointer): bool {.stdcall.}  =
  case ul_reason_for_call
  of DLL_PROCESS_ATTACH:
    discard
  of DLL_PROCESS_DETACH:
    discard
  else:
    discard
  result = true

proc cnew*[T](x: T): ptr T {.importcpp: "(new '*0#@)", nodecl.}
proc constructExampleModule(): ExampleModule {.importcpp: "ExampleAIModule(@)".}

proc onStart() {.cdecl.} =
  BroodwarPtr[].print("hello from Nim!")

# extern "C" __declspec(dllexport) BWAPI::AIModule* newAIModule()
proc newAIModule(): ptr AIModule {.cdecl,exportc,dynlib.} =
  var ai = cnew constructExampleModule()
  ai[].setOnStartCallback(onStart)
  result = ai

# Include ExampleAIModule.cpp, but it could be a static lib that is linked in.
{.compile: "cpp/ExampleAIModule.cpp".}
