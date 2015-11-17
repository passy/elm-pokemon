module Pokemon where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Signal, Mailbox, Address)
import String

type alias Model = String

initialModel : Model
initialModel = "pikachu"

main : Signal Html
main =
  Signal.map (view actions.address) model

type Action = NoOp | UpdateField String

actions : Signal.Mailbox Action
actions = Signal.mailbox NoOp

model : Signal Model
model = Signal.foldp update initialModel actions.signal

update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model
    UpdateField str -> str |> String.toLower |> String.trim

view : Address Action -> Model -> Html
view address model = div []
  [ img [ src <| "http://img.pokemondb.net/artwork/" ++ model ++ ".jpg" ] []
  , br [] []
  , input
    [ on "input" targetValue (Signal.message address << UpdateField)
    , autofocus True
    , value model
    ] []
  ]
