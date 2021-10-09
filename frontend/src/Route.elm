module Route exposing (..)

import Url.Parser exposing (Parser, (</>), map, oneOf, s, parse)
import Url exposing (Url)

type Route
  = Main
  | EntryEditor
  | NotFound

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Main          (s (pathOf Main))
    , map EntryEditor    (s (pathOf EntryEditor))
    ]  

parseUrl: Url -> Route
parseUrl url = Maybe.withDefault NotFound (parse routeParser url)

labelOf : Route -> String
labelOf route = 
  case route of
     Main -> "Main"
     EntryEditor -> "Entry Editor"
     _ -> "Not Found"

pathOf : Route -> String
pathOf route = 
  String.replace " " "" (labelOf route)

 