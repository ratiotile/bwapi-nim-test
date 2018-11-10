import os
import nim_bwapi/BWAPI
import nim_bwapi/BWAPI/Game
import nim_bwapi/BWAPI/Client/Client

proc reconnect() =
  while not BWAPIClient.connect():
    sleep(1000)

proc mainLoop() =
  while Broodwar.isInGame():
    echo "in game!"
    sleep(10000)

proc main() =
  echo "Client BWAPI rev=", BWAPI_getRevision()
  echo "connecting..."
  reconnect()
  while true:
    echo "waiting to enter match"
    while not(Broodwar.isInGame()):
      BWAPIClient.update()
      if not BWAPIClient.isConnected():
        echo "Reconnecting..."
        reconnect()
    echo "Starting match!"
    mainLoop()

main()
