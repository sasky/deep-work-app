module Main exposing (Model, Msg(..), Task, main)

import Browser
import Html exposing (Html, h2, li, pre, section, span, text, ul)
import Html.Attributes exposing (class, classList, list, selected)



-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Debug.todo "add some style elm ui or tail wind"
-- Debug.todo "move list items around by drag and drop"
-- Debug.todo "Add a Select merchanic ( only one item to be selected at a time ) "
-- Debug.todo "move list items around by arrows when selected"
-- MODEL


type alias Model =
    List Task


type alias Task =
    { id : Int
    , text : String
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
    [ { id = 1
      , text = "example todo task"
      , minutes = 45
      , selected = False
      , status = Todo
      }
    , { id = 2
      , text = " another example todo task"
      , minutes = 20
      , selected = False
      , status = Todo
      }
    , { id = 3
      , text = "example Doing task"
      , minutes = 45
      , selected = False
      , status = Doing
      }
    , { id = 4
      , text = "example done task"
      , minutes = 45
      , selected = False
      , status = Done
      }
    , { id = 5
      , text = " another example done task"
      , minutes = 20
      , selected = False
      , status = Done
      }
    ]



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



-- SUBSCRIPTIONS
-- VIEW


view : Model -> Html Msg
view model =
    section []
        [ h2 [] [ text "Doing" ]
        , renderTasks Doing model
        , h2 [] [ text "Todo" ]
        , renderTasks Todo model
        , h2 [] [ text "Done" ]
        , renderTasks Done model
        ]


renderTasks : Status -> Model -> Html Msg
renderTasks status model =
    ul []
        (List.filter (\t -> t.status == status) model
            |> List.map renderTask
        )


renderTask : Task -> Html Msg
renderTask task =
    li []
        [ span [ class "text" ] [ text task.text ]
        , span [ class "minutes" ] [ text (String.fromInt task.minutes) ]
        ]



-- [ span [ class "text" ] [ text task.text ] ]
-- , [ span [ class "minutes" ] [ text task.minutes ] ]
