module Test.Generated.Main3178760252 exposing (main)

import CoordinateTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "CoordinateTests" [CoordinateTests.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 314455761275531, processes = 8, globs = [], paths = ["/Users/adauguet/Projects/elm/warmer/tests/CoordinateTests.elm"]}