module RouteParser exposing (..)

import Url.Parser exposing (Parser, (</>), map, oneOf, s)

type Route
  = Main
  | CreateForm

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Main          (s "main" )
    , map CreateForm    (s "createform")
    ]