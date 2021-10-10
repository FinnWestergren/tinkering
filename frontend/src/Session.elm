module Session exposing (Session, navKey, toSession)

import Browser.Navigation as Nav
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, required)
import Json.Encode as Encode exposing (Value)

-- TYPES

type Session
    = LoggedIn Nav.Key
    | Guest Nav.Key

-- INFO

navKey : Session -> Nav.Key
navKey session =
    case session of
        LoggedIn key ->
            key

        Guest key ->
            key

toSession : Nav.Key -> Session
toSession key = LoggedIn key