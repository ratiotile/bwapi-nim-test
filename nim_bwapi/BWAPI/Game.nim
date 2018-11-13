
type
  Game* {.importcpp: "BWAPI::Game", header: "BWAPI/Game.h".} = object
  GameWrapper* {.importcpp: "BWAPI::GameWrapper", header: "BWAPI/Game.h".} = object

proc isInGame*(this: Game): bool {.importcpp: "isInGame", header: "BWAPI/Game.h".}

proc isInGame*(this: GameWrapper): bool {.importcpp: "#->isInGame()", header: "BWAPI/Game.h".}

proc print*(this: Game, format: cstring): void {.importcpp: "printf", varargs, header: "BWAPI/Game.h".}

var BroodwarPtr* {.importcpp: "BWAPI::BroodwarPtr", header: "BWAPI/Game.h".} :
  ptr Game

var Broodwar* {.importcpp: "BWAPI::Broodwar", header: "BWAPI/Game.h".} :
  GameWrapper

proc deref*(this: GameWrapper): Game {.importcpp: "#->@", header: "BWAPI/Game.h".}
