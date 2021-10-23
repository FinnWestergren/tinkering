module Route exposing (..)

import Url.Parser exposing (Parser, (</>), map, oneOf, s, parse)
import Browser.Navigation as Nav
import Url exposing (Url)

type Route
  = Home
  | EntryEditor
  | NotFound

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Home          (s (pathOf Home))
    , map EntryEditor    (s (pathOf EntryEditor))
    ]  

parseUrl: Url -> Route
parseUrl url = Maybe.withDefault NotFound (parse routeParser url)

labelOf : Route -> String
labelOf route = 
  case route of
    Home -> "Home"
    EntryEditor -> "Entry Editor"
    _ -> "Not Found"

pathOf : Route -> String
pathOf route = 
  String.replace " " "" (labelOf route)


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (pathOf route)
