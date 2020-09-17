module Main exposing (Model, Msg(..), Task, main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)



-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



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


init : Model
init =
    { tasks =
        [ { text = "example todo task"
          , minutes = 45
          , selected = False
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



-- UPDATE


type Msg
    = Add Task
    | Delete Int
    | Edit Task


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add task ->
            model

        Delete id ->
            model

        Edit task ->
            model



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
            ]
            [ column
                [ width (fillPortion 1)
                , height fill
                , Background.color colours.grey
                ]
                [ text "left" ]
            , column
                [ width (fillPortion 4)
                , height fill
                , Background.color colours.darkGrey
                ]
                (List.map
                    viewTask
                    model.tasks
                )
            , column
                [ width (fillPortion 1)
                , height fill
                , Background.color colours.grey
                ]
                [ text "right" ]
            ]
        )



-- (List.map viewTask model.tasks))


viewTask : Task -> Element Msg
viewTask task =
    row
        [ paddingXY 0 20
        , centerX
        , width fill
        ]
        [ el
            [ padding 30
            , width fill
            , Border.widthEach { right = 1, left = 1, top = 1, bottom = 1 }
            , Border.color colours.teal
            ]
            (text task.text)
        ]
