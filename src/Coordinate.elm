module Coordinate exposing
    ( Coordinate
    , Distance(..)
    , color
    , description
    , distance
    , fromInt
    , generator
    , toInt
    )

import Element exposing (Color)
import Element.Extra exposing (hex)
import Random exposing (Generator)


type alias Coordinate =
    { row : Int
    , column : Int
    }


fromInt : Int -> Int -> Coordinate
fromInt size int =
    { row = int // size
    , column = modBy size int
    }


toInt : Int -> Coordinate -> Int
toInt size { row, column } =
    row * size + column


description : Coordinate -> String
description { row, column } =
    "(" ++ String.fromInt row ++ ", " ++ String.fromInt column ++ ")"


distance : Coordinate -> Coordinate -> Distance
distance c1 c2 =
    abs (c2.row - c1.row) + abs (c2.column - c1.column) |> Distance


generator : Int -> Int -> Generator Coordinate
generator row column =
    Random.map2 Coordinate
        (Random.int 0 row)
        (Random.int 0 column)



-- Distance


type Distance
    = Distance Int


color : Distance -> Color
color (Distance int) =
    case int of
        0 ->
            hex 0x00FFD60A

        1 ->
            hex 0x00CB1B16

        2 ->
            hex 0x00EF3C2D

        3 ->
            hex 0x00F26A4F

        4 ->
            hex 0x00F29479

        5 ->
            hex 0x00FEDFD4

        _ ->
            hex 0x009DCEE2
