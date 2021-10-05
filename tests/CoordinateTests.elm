module CoordinateTests exposing (..)

import Coordinate exposing (Distance(..))
import Expect exposing (equal)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "the Coordinate module"
        [ describe "fromInt"
            [ test "10 0" <| \_ -> equal (Coordinate.fromInt 10 0) { row = 0, column = 0 }
            , test "10 2" <| \_ -> equal (Coordinate.fromInt 10 2) { row = 0, column = 2 }
            , test "10 24" <| \_ -> equal (Coordinate.fromInt 10 24) { row = 2, column = 4 }
            , test "10 57" <| \_ -> equal (Coordinate.fromInt 10 57) { row = 5, column = 7 }
            , test "10 99" <| \_ -> equal (Coordinate.fromInt 10 99) { row = 9, column = 9 }
            ]
        , describe "toInt"
            [ test "10 { row = 0, column = 0 }" <| \_ -> equal (Coordinate.toInt 10 { row = 0, column = 0 }) 0
            , test "10 { row = 0, column = 2 }" <| \_ -> equal (Coordinate.toInt 10 { row = 0, column = 2 }) 2
            , test "10 { row = 2, column = 4 }" <| \_ -> equal (Coordinate.toInt 10 { row = 2, column = 4 }) 24
            , test "10 { row = 5, column = 7 }" <| \_ -> equal (Coordinate.toInt 10 { row = 5, column = 7 }) 57
            , test "10 { row = 9, column = 9 }" <| \_ -> equal (Coordinate.toInt 10 { row = 9, column = 9 }) 99
            ]
        , describe "distance"
            [ test "(0, 1) (2, 4) = 5" <| \_ -> equal (Coordinate.distance { row = 0, column = 1 } { row = 2, column = 4 }) (Distance 5)
            , test "(1, 7) (8, 4) = 10" <| \_ -> equal (Coordinate.distance { row = 1, column = 7 } { row = 8, column = 4 }) (Distance 10)
            , test "(4, 4) (4, 4) = 0" <| \_ -> equal (Coordinate.distance { row = 4, column = 4 } { row = 4, column = 4 }) (Distance 0)
            ]
        ]
