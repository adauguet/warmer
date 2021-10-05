module List.ExtraTests exposing (..)

import Expect exposing (equal)
import List.Extra exposing (chunk)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "chunk"
        [ test "chunk -1 []" <| \_ -> equal (chunk -1 []) []
        , test "chunk 0 []" <| \_ -> equal (chunk 0 []) []
        , test "chunk 1 []" <| \_ -> equal (chunk 1 []) []
        , test "chunk 2 [1, 2, 3]" <|
            \_ ->
                equal (chunk 2 (List.range 1 3))
                    [ [ 1, 2 ]
                    , [ 3 ]
                    ]
        , test "chunk 5 (List.range 0 33) " <|
            \_ ->
                equal (chunk 5 (List.range -17 33))
                    [ [ -17, -16, -15, -14, -13 ]
                    , [ -12, -11, -10, -9, -8 ]
                    , [ -7, -6, -5, -4, -3 ]
                    , [ -2, -1, 0, 1, 2 ]
                    , [ 3, 4, 5, 6, 7 ]
                    , [ 8, 9, 10, 11, 12 ]
                    , [ 13, 14, 15, 16, 17 ]
                    , [ 18, 19, 20, 21, 22 ]
                    , [ 23, 24, 25, 26, 27 ]
                    , [ 28, 29, 30, 31, 32 ]
                    , [ 33 ]
                    ]
        , test "chunk 7 (List.range 1 50)" <|
            \_ ->
                equal (chunk 7 (List.range 1 50))
                    [ [ 1, 2, 3, 4, 5, 6, 7 ]
                    , [ 8, 9, 10, 11, 12, 13, 14 ]
                    , [ 15, 16, 17, 18, 19, 20, 21 ]
                    , [ 22, 23, 24, 25, 26, 27, 28 ]
                    , [ 29, 30, 31, 32, 33, 34, 35 ]
                    , [ 36, 37, 38, 39, 40, 41, 42 ]
                    , [ 43, 44, 45, 46, 47, 48, 49 ]
                    , [ 50 ]
                    ]
        ]
