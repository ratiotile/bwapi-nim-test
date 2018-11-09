
type
  Game* {.importcpp: "BWAPI::Game", header: "BWAPI/Game.h".} = object
  GameWrapper* {.importcpp: "BWAPI::GameWrapper", header: "BWAPI/Game.h".} = object

proc isInGame*(this: Game): bool {.importcpp: "isInGame", header: "BWAPI/Game.h".}

proc isInGame*(this: GameWrapper): bool {.importcpp: "#->isInGame()", header: "BWAPI/Game.h".}

var Broodwar* {.importcpp: "BWAPI::Broodwar", header: "BWAPI/Game.h".} :GameWrapper

proc deref*(this: GameWrapper): Game {.importcpp: "#->@", header: "BWAPI/Game.h".}
