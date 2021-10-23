module Pages.Home exposing (..)
import Html exposing (Html)
import Html exposing (div)
import Html.Events exposing (onClick)
import Html exposing (button)
import Html exposing (text)
import Html exposing (li)
import Html exposing (ol)
import List exposing (map)
import Date exposing (Date)
import Html exposing (span)
import Date exposing (toIsoString)

type alias Model = {
    posts: List Post
    }

type alias Post = { title: String, date: Date }

-- UPDATE

type Msg = 
    None

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

-- VIEW

view : Model -> Html msg
view model = div []
    [ol [] (map renderPost model.posts) ] 

renderPost : Post -> Html msg
renderPost post = 
    li [] [
        span [] [text post.title],
        span [] [text (toIsoString post.date)]
    ]