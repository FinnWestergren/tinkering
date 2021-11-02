module Route exposing (..)

import Url.Parser exposing (Parser, (</>), map, oneOf, s, parse, top)
import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser exposing (string)

type Route
  = Home
  | BlogPost String
  | NotFound

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map BlogPost (s "Post" </> string)
    , map Home top
    ]

parseUrl: Url -> Route
parseUrl url = Maybe.withDefault NotFound (parse routeParser url)

labelOf : Route -> String
labelOf route = 
  case route of
    Home -> "Home"
    BlogPost _ -> "Post"
    _ -> "Not Found"

pathOf : Route -> String
pathOf route = 
  case route of
    Home -> ""
    BlogPost id -> "Post/" ++ id
    _ -> "Not Found"


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (pathOf route)
