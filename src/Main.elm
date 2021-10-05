module Main exposing (main)

import Browser
import Coordinate exposing (Coordinate, Distance(..))
import Element
    exposing
        ( Attribute
        , Element
        , alignRight
        , centerX
        , centerY
        , column
        , el
        , fill
        , focusStyle
        , height
        , layout
        , layoutWith
        , none
        , px
        , rgb255
        , row
        , spacing
        , text
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Grid exposing (Grid)
import Html exposing (Html)
import List.Extra as List
import Random exposing (generate)
import Tile exposing (Tile)


type Model
    = Idle
    | Loaded LoadedState Grid


type LoadedState
    = Playing
    | Won


init : () -> ( Model, Cmd Msg )
init _ =
    ( Idle
    , generate GotRandomCoordinate (Coordinate.generator 9 9)
    )


type Msg
    = ClickedTile Coordinate
    | GotRandomCoordinate Coordinate
    | Restart


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedTile coordinate ->
            case model of
                Loaded Playing grid ->
                    let
                        newGrid =
                            Grid.reveal coordinate grid
                    in
                    if Grid.isKey newGrid coordinate then
                        ( Loaded Won newGrid, Cmd.none )

                    else
                        ( Loaded Playing newGrid, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        GotRandomCoordinate coordinate ->
            ( Loaded Playing <| Grid.new 10 coordinate, Cmd.none )

        Restart ->
            ( Idle, generate GotRandomCoordinate (Coordinate.generator 9 9) )


view : Model -> Html Msg
view model =
    case model of
        Idle ->
            layout [] none

        Loaded state grid ->
            layoutWith
                { options =
                    [ focusStyle
                        { borderColor = Nothing
                        , backgroundColor = Nothing
                        , shadow = Nothing
                        }
                    ]
                }
                []
            <|
                column [ centerX, centerY, spacing 32 ]
                    [ row
                        [ width fill ]
                        [ text <| String.fromInt <| Grid.revealedTiles grid
                        , el [ alignRight ] <| scale
                        ]
                    , gridView grid state
                    , Input.button [ alignRight ] { onPress = Just Restart, label = text "Recommencer" }
                    ]


gridView : Grid -> LoadedState -> Element Msg
gridView grid state =
    Grid.getTiles grid
        |> List.map (tileRow (Grid.distance grid) state)
        |> column [ spacing 4 ]


tileRow : (Coordinate -> Distance) -> LoadedState -> List Tile -> Element Msg
tileRow toDistance state tiles =
    Element.row [ spacing 4 ] <|
        List.map
            (case state of
                Playing ->
                    activeTileView toDistance

                Won ->
                    inactiveTileView toDistance
            )
            tiles


tileAttributes : (Coordinate -> Distance) -> Tile -> List (Attribute msg)
tileAttributes toDistance tile =
    [ width <| px 30
    , height <| px 30
    , Border.rounded 2
    , Border.width 1
    , Border.color <| rgb255 200 200 200
    , if tile.isRevealed then
        Background.color <| Coordinate.color (toDistance tile.coordinate)

      else
        Background.color <| rgb255 255 255 255
    ]


activeTileView : (Coordinate -> Distance) -> Tile -> Element Msg
activeTileView toDistance tile =
    Input.button
        (tileAttributes toDistance tile)
        { onPress = Just <| ClickedTile tile.coordinate
        , label = el [ Font.size 10, centerX, centerY ] none
        }


inactiveTileView : (Coordinate -> Distance) -> Tile -> Element msg
inactiveTileView toDistance tile =
    el (tileAttributes toDistance tile) none


scale : Element msg
scale =
    List.range 0 6
        |> List.map (\int -> scaleStepView <| Distance int)
        |> List.reverse
        |> row [ spacing 4 ]


scaleStepView : Distance -> Element msg
scaleStepView distance =
    el
        [ width <| px 30
        , height <| px 30
        , Border.rounded 2
        , Border.width 1
        , Border.color <| rgb255 200 200 200
        , Background.color <| Coordinate.color distance
        ]
        none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
