module Element.Extra exposing (hex)

import Element exposing (Color, rgb255)


hex : Int -> Color
hex h =
    let
        ( r, remainder ) =
            divModBy (256 * 256) h

        ( g, b ) =
            divModBy 256 remainder
    in
    rgb255 r g b


divModBy : Int -> Int -> ( Int, Int )
divModBy by n =
    ( n // by, modBy by n )
