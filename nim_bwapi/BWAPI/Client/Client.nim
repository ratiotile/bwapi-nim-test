# Wrap BWAPI::Client

type
  Client*  {.importcpp: "BWAPI::Client", header: "BWAPI/Client/Client.h".} = object

proc isConnected*(this: Client): bool {.noSideEffect,
  importcpp: "isConnected",
  header: "BWAPI/Client/Client.h".}

proc connect*(this: var Client): bool {.
  importcpp: "connect", header: "BWAPI/Client/Client.h".}
proc disconnect*(this: var Client) {.
  importcpp: "disconnect", header: "BWAPI/Client/Client.h".}
proc update*(this: var Client) {.
  importcpp: "update", header: "BWAPI/Client/Client.h".}

var BWAPIClient* {.importcpp: "BWAPI::BWAPIClient", header: "BWAPI/Client/Client.h".}: Client

#[
proc constructClient*(): Client {.constructor, importcpp: "BWAPI::Client(@)",
                               header: "Client.h".}
proc destroyClient*(this: var Client) {.importcpp: "#.~Client()", header: "Client.h".}
]#
