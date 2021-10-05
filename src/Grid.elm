module Grid exposing (Grid, distance, getTiles, isKey, new, reveal, revealedTiles)

import Coordinate exposing (Coordinate, Distance)
import List.Extra as List
import Tile exposing (Tile)


new : Int -> Coordinate -> Grid
new size key =
    List.range 0 (size * size - 1)
        |> List.map (Coordinate.fromInt size)
        |> List.map Tile.new
        |> List.chunk size
        |> Grid key


type Grid
    = Grid Coordinate (List (List Tile))


getTiles : Grid -> List (List Tile)
getTiles (Grid _ tiles) =
    tiles


reveal : Coordinate -> Grid -> Grid
reveal coordinate (Grid key tiles) =
    tiles
        |> List.map (List.map (Tile.reveal coordinate))
        |> Grid key


distance : Grid -> Coordinate -> Distance
distance (Grid key _) coordinate =
    Coordinate.distance key coordinate


isKey : Grid -> Coordinate -> Bool
isKey (Grid key _) coordinate =
    coordinate == key


revealedTiles : Grid -> Int
revealedTiles (Grid _ tiles) =
    tiles
        |> List.concat
        |> List.filter .isRevealed
        |> List.length
