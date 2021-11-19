module Pages.BlogPost exposing (Model, init, update, view, Msg)
import Html exposing (..)
import Time exposing (Month(..))
import Http
import Json.Decode exposing (..)
import Markdown

-- MODEL

type Model 
    = Loading
    | Loaded Post
    | Failure

type alias Post = { title: String, date: String, body: String }

init: String ->  String -> (Model, Cmd Msg)
init serverAddress postId = (Loading, httpFetchPost serverAddress postId) 

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
view model = Html.div [] [
        (renderPostsSection model)
    ]

renderPostsSection: Model -> Html msg
renderPostsSection model =
    case model of
        Loaded post -> renderPost post
        Loading -> span [] [text "Loading"]
        Failure -> span [] [text "Error"]

renderPost : Post -> Html msg
renderPost post = 
    div [] [
        span [] [h3 [] [text post.title]],
        span [] [h4 [] [text post.date]],
        renderBody post.body
    ]


renderBody : String -> Html msg
renderBody body = 
    div []
        <| Markdown.toHtml Nothing body
-- HTTP

httpFetchPost : String -> String -> Cmd Msg
httpFetchPost serverAddress id =
    Http.get
    { url = serverAddress ++ "/Post/" ++ id
    , expect = Http.expectJson PostRetrieved postDecoder
    }

postDecoder : Decoder Post
postDecoder = 
    map3 Post
    (field "title" string)
    (field "date" string)
    (field "body" string)
