##  Forward declarations
#[
discard "forward decl of PlayerInterface"
type
  Player* = ptr PlayerInterface

discard "forward decl of Color"
]#
type
  AIModule* {.importcpp: "BWAPI::AIModule", header: "BWAPI/AIModule.h".} = object of RootObj

#[
proc constructAIModule*(): AIModule {.constructor, importcpp: "BWAPI::AIModule(@)",
                                   header: "AIModule.h".}
proc destroyAIModule*(this: var AIModule) {.importcpp: "#.~AIModule()",
                                        header: "AIModule.h".}
proc onStart*(this: var AIModule) {.importcpp: "onStart", header: "AIModule.h".}
proc onEnd*(this: var AIModule; isWinner: bool) {.importcpp: "onEnd",
    header: "AIModule.h".}
proc onFrame*(this: var AIModule) {.importcpp: "onFrame", header: "AIModule.h".}
proc onSendText*(this: var AIModule; text: string) {.importcpp: "onSendText",
    header: "AIModule.h".}
proc onReceiveText*(this: var AIModule; player: Player; text: string) {.
    importcpp: "onReceiveText", header: "AIModule.h".}
proc onPlayerLeft*(this: var AIModule; player: Player) {.importcpp: "onPlayerLeft",
    header: "AIModule.h".}
proc onNukeDetect*(this: var AIModule; target: Position) {.importcpp: "onNukeDetect",
    header: "AIModule.h".}
proc onUnitDiscover*(this: var AIModule; unit: Unit) {.importcpp: "onUnitDiscover",
    header: "AIModule.h".}
proc onUnitEvade*(this: var AIModule; unit: Unit) {.importcpp: "onUnitEvade",
    header: "AIModule.h".}
proc onUnitShow*(this: var AIModule; unit: Unit) {.importcpp: "onUnitShow",
    header: "AIModule.h".}
proc onUnitHide*(this: var AIModule; unit: Unit) {.importcpp: "onUnitHide",
    header: "AIModule.h".}
proc onUnitCreate*(this: var AIModule; unit: Unit) {.importcpp: "onUnitCreate",
    header: "AIModule.h".}
proc onUnitDestroy*(this: var AIModule; unit: Unit) {.importcpp: "onUnitDestroy",
    header: "AIModule.h".}
proc onUnitMorph*(this: var AIModule; unit: Unit) {.importcpp: "onUnitMorph",
    header: "AIModule.h".}
proc onUnitRenegade*(this: var AIModule; unit: Unit) {.importcpp: "onUnitRenegade",
    header: "AIModule.h".}
proc onSaveGame*(this: var AIModule; gameName: string) {.importcpp: "onSaveGame",
    header: "AIModule.h".}
proc onUnitComplete*(this: var AIModule; unit: Unit) {.importcpp: "onUnitComplete",
    header: "AIModule.h".}
## / <summary>TournamentModule is a virtual class that is intended to be implemented or inherited
## / by a custom Tournament class.</summary> Like AIModule, the Broodwar interface is guaranteed
## / to be initialized if any of these predefined interface functions are invoked by BWAPI.
## /
## / @note
## /   The TournamentModule is to be implemented by Tournament Modules ONLY. A standard AI module
## /   should never implement it. The Tournament Module is invoked only if it is explicitly
## /   defined in the configuration file. Tournament Modules also contain an AI Module interface
## /   so that it can monitor the time an AI module spent during its calls using
## /   Game::getLastEventTime.
## /
## / @ingroup Interface

type
  TournamentModule* {.importcpp: "BWAPI::TournamentModule", header: "AIModule.h".} = object


proc constructTournamentModule*(): TournamentModule {.constructor,
    importcpp: "BWAPI::TournamentModule(@)", header: "AIModule.h".}
proc destroyTournamentModule*(this: var TournamentModule) {.
    importcpp: "#.~TournamentModule()", header: "AIModule.h".}
proc onAction*(this: var TournamentModule; actionType: ActionID;
              parameter: pointer = nullptr): bool {.importcpp: "onAction",
    header: "AIModule.h".}
proc onFirstAdvertisement*(this: var TournamentModule) {.
    importcpp: "onFirstAdvertisement", header: "AIModule.h".}
]#
