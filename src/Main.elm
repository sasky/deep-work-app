module Main exposing (Model, Msg(..), Task, main)

import Browser
import Browser.Events as Events exposing (onKeyDown)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Json.Decode exposing (Decoder, field, string)



-- onKeyUp : (Int -> msg) -> Attribute msg
-- onKeyUp tagger =
--   on "keyup" (Json.map tagger keyCode)


keyDecoder : Decoder Msg
keyDecoder =
    Json.Decode.map mapKeyToMsg (field "key" string)


mapKeyToMsg : String -> Msg
mapKeyToMsg key =
    case key of
        "ArrowUp" ->
            MoveSelectedUp

        "ArrowDown" ->
            MoveSelectedDown

        _ ->
            NoOp



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onKeyDown keyDecoder



-- Debug.todo " up and down arrow keys to move selected"
-- Debug.todo "add colours and layout ( still mvp)"
-- Debug.todo "Add a Select merchanic ( only one item to be selected at a time ) "
-- Debug.todo "move list items around by arrows when selected"
-- Debug.todo "move list items around by drag and drop"
-- MODEL


type alias Model =
    { tasks : List Task
    }


type alias Task =
    { text : String
    , minutes : Int
    , selected : Bool
    , status : Status
    }


type Status
    = Todo
    | Doing
    | Done


init : () -> ( Model, Cmd Msg )
init _ =
    ( { tasks =
            [ { text = "example todo task"
              , minutes = 45
              , selected = True
              , status = Todo
              }
            , { text = " another example todo task"
              , minutes = 20
              , selected = False
              , status = Todo
              }
            , { text = "example Doing task"
              , minutes = 45
              , selected = False
              , status = Doing
              }
            , { text = "example done task"
              , minutes = 45
              , selected = False
              , status = Done
              }
            , { text = " another example done task"
              , minutes = 20
              , selected = False
              , status = Done
              }
            ]
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Add Task
    | Delete Int
    | Edit Task
    | MoveSelectedUp
    | MoveSelectedDown
    | NoOp


shiftItems : Task -> ( List Task, Bool ) -> ( List Task, Bool )
shiftItems task carry =
    let
        ( proccessedTasks, applySelected ) =
            carry
    in
    ( proccessedTasks ++ [ { task | selected = applySelected } ], task.selected )


shiftSelectedTasks : List Task -> List Task
shiftSelectedTasks tasks =
    let
        ( shiftedTasks, firstSelected ) =
            List.foldl shiftItems ( [], False ) tasks
    in
    case List.head shiftedTasks of
        Just task ->
            shiftedTasks
                |> List.drop 1
                |> List.append [ { task | selected = firstSelected } ]

        Nothing ->
            shiftedTasks



-- shiftSelectedTasks


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add task ->
            ( model, Cmd.none )

        Delete id ->
            ( model, Cmd.none )

        Edit task ->
            ( model, Cmd.none )

        MoveSelectedUp ->
            ( { model
                | tasks =
                    model.tasks
                        |> List.reverse
                        |> shiftSelectedTasks
                        |> List.reverse
              }
            , Cmd.none
            )

        MoveSelectedDown ->
            let
                newModel =
                    { model
                        | tasks =
                            model.tasks
                                |> shiftSelectedTasks
                    }
            in
            ( newModel, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- View
-- Colours
-- colours :


colours =
    { green = rgb255 138 220 84
    , red = rgb255 255 50 116
    , purple = rgb255 145 120 222
    , teal = rgb255 66 215 228
    , yellow = rgb255 255 209 60
    , grey = rgb255 87 85 87
    , darkGrey = rgb255 34 31 35
    }


view : Model -> Html Msg
view model =
    Element.layout
        [ Font.color (rgb255 251 251 248)
        ]
        (row
            [ width fill
            , height fill
            , Background.color colours.darkGrey
            ]
            [ column
                [ width (fillPortion 1)
                , height fill
                ]
                [ text "left" ]
            , column
                [ width (fillPortion 10)
                , height fill
                ]
                (List.map
                    viewTask
                    model.tasks
                )
            , column
                [ width (fillPortion 1)
                , height fill
                ]
                [ text "right" ]
            ]
        )



-- (List.map viewTask model.tasks))


viewTask : Task -> Element Msg
viewTask task =
    let
        border =
            if task.selected then
                Border.widthEach { right = 1, left = 1, top = 1, bottom = 1 }

            else
                Border.widthEach { right = 0, left = 0, top = 0, bottom = 0 }
    in
    row
        [ paddingXY 0 20
        , centerX
        , width fill
        ]
        [ row
            [ padding 30
            , width fill
            , border
            , Border.color colours.teal
            ]
            [ el
                [ width (fillPortion 7)
                ]
                (text task.text)
            , el
                [ width (fillPortion 1)
                ]
                (text (String.fromInt task.minutes ++ "m"))
            ]
        ]
