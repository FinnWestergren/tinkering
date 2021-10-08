module EntryCreate.CreationForm exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

createForm = Browser.sandbox { init = init, update = update, view = view }
