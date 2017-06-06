## / <summary>The primary namespace for the BWAPI interface.</summary> Everything that is BWAPI is
## / contained within it.

## / <summary>Retrieves the revision of the BWAPILIB module currently being used.</summary>
## /
## / @returns
## /   An integer representing the revision number of the library.
## /
## / @threadsafe

proc BWAPI_getRevision*(): cint {.importcpp: "BWAPI::BWAPI_getRevision(@)",
                               header: "BWAPI.h".}
## / <summary>Checks if the BWAPILIB module was compiled in DEBUG mode.</summary>
## /
## / @retval true if this is a DEBUG build
## / @retval false if this is a RELEASE build
## /
## / @threadsafe

proc BWAPI_isDebug*(): bool {.importcpp: "BWAPI::BWAPI_isDebug(@)", header: "BWAPI.h".}
var BWAPI_REVISION* {.importcpp: "BWAPI_REVISION", header: "BWAPI.h".}: cint
