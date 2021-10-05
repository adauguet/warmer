module Test.Generated.Main3969192321 exposing (main)

import CoordinateTests
import List.ExtraTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "CoordinateTests" [CoordinateTests.suite],     Test.describe "List.ExtraTests" [List.ExtraTests.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 393776080888833, processes = 8, globs = [], paths = ["/Users/adauguet/Projects/elm/warmer/tests/CoordinateTests.elm","/Users/adauguet/Projects/elm/warmer/tests/List/ExtraTests.elm"]}