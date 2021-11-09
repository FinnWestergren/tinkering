module Pages.BlogPost exposing (Model, init, update, view, Msg)
import Date exposing (Date)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Css exposing (marginRight)
import Css exposing (px)
import Date exposing (toIsoString)
import Process
import Task
import Date exposing (fromCalendarDate)
import Time exposing (Month(..))

-- MODEL

type Model 
    = Loading
    | Loaded Post

type alias Post = { title: String, date: Date, id: String }

init: String -> (Model, Cmd Msg)
init postId = (Loading, httpFetchPost postId) 

-- UPDATE

type Msg = PostRetrieved Post

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ = 
    case msg of
        PostRetrieved post -> (Loaded post, Cmd.none)

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

renderPost : Post -> Html msg
renderPost post = 
    div [] [
        span [css [marginRight (px 40)]] [text post.title] ,
        span [css [marginRight (px 40)]] [text (toIsoString post.date)],
        span [] [text post.id]
    ]

-- HTTP

httpFetchPost : String -> Cmd Msg
httpFetchPost id =
    let
        task = Process.sleep 100
        msg = PostRetrieved (testPostModel id)
    in
    task
        |> Task.perform (\_ -> msg)

testPostModel : String -> Post
testPostModel id = {title = "test_1", date = fromCalendarDate 2021 Jan 1, id = id}
