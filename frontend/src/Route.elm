module Route exposing (..)

import Url.Parser exposing (Parser, (</>), map, oneOf, s, parse, top)
import Browser.Navigation as Nav
import Url exposing (Url)

type Route
  = Home
  | BlogPost
  | NotFound

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Home          (s (pathOf Home))
    , map BlogPost    (s (pathOf BlogPost))
    , map Home            top
    ]

parseUrl: Url -> Route
parseUrl url = Maybe.withDefault NotFound <| Debug.log "url" (parse routeParser url)

labelOf : Route -> String
labelOf route = 
  case route of
    Home -> "Home"
    BlogPost -> "Post"
    _ -> "Not Found"

pathOf : Route -> String
pathOf route = 
  String.replace " " "" (labelOf route)


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (pathOf route)
