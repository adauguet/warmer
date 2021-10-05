module Tile exposing (Tile, new, reveal)

import Coordinate exposing (Coordinate)


type alias Tile =
    { coordinate : Coordinate
    , isRevealed : Bool
    }


new : Coordinate -> Tile
new coordinate =
    { coordinate = coordinate
    , isRevealed = False
    }


reveal : Coordinate -> Tile -> Tile
reveal coordinate tile =
    if tile.coordinate == coordinate then
        { tile | isRevealed = True }

    else
        tile
