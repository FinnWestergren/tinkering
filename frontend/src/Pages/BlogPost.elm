module Pages.BlogPost exposing (Model, init, update, view, Msg)
import Date exposing (Date)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Css exposing (marginRight)
import Css exposing (px)
import Date exposing (toIsoString)
import Date exposing (fromCalendarDate)
import Time exposing (Month(..))
import Http
import Json.Decode exposing (..)
import Svg.Styled.Attributes exposing (result)
import Css exposing (marginTop)
import Css exposing (marginLeft)
import Css exposing (display)
import Css exposing (inlineBlock)

-- MODEL

type Model 
    = Loading
    | Loaded Post
    | Failure

type alias Post = { title: String, date: String, body: String }

init: String -> (Model, Cmd Msg)
init postId = (Loading, httpFetchPost postId) 

-- UPDATE

type Msg = 
    PostRetrieved (Result Http.Error (Post))

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ = 
    case msg of
        PostRetrieved result ->
            case result of
                Ok post -> (Loaded post, Cmd.none)
                _ -> (Failure, Cmd.none)

-- VIEW

view : Model -> Html msg
view model = div [] [
        renderPostsSection model
    ]

renderPostsSection: Model -> Html msg
renderPostsSection model =
    case model of
        Loaded post -> renderPost post
        Loading -> span [] [text "Loading"]
        Failure -> span [] [text "Error"]

renderPost : Post -> Html msg
renderPost post = 
    div [css [marginLeft (px 20)]] [
        span [css [marginRight (px 40)]] [h3 [css [display inlineBlock]] [text post.title]] ,
        span [css [marginRight (px 40)]] [h4 [css [display inlineBlock]] [text post.date]],
        div [] [text post.body]
    ]

-- HTTP

httpFetchPost : String -> Cmd Msg
httpFetchPost id =
    Http.get
    { url = Debug.log "test" ("http://localhost:3000/Post/" ++ id)
    , expect = Http.expectJson PostRetrieved postDecoder
    }

postDecoder : Decoder Post
postDecoder = 
    map3 Post
    (field "title" string)
    (field "date" string)
    (field "body" string)
