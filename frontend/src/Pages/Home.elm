module Pages.Home exposing (..)
import Html exposing (Html)
import Html exposing (div)
import Html.Events exposing (onClick)
import Html exposing (button)
import Html exposing (text)
import Html exposing (li)
import Html exposing (ol)
import List exposing (map)

type alias Model = {
    posts: List Post
    }

type alias Post = { title: String }

-- UPDATE

type Msg = 
    None

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model = div []
    [ol [] (map renderPost model.posts) ] 

renderPost : Post -> Html Msg
renderPost post = li [] [text post.title]