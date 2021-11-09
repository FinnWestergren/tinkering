module Pages.Home exposing (init, update, view, Msg, renderPost, Model(..))
import List
import Date exposing (Date, toIsoString, fromCalendarDate)
import Time exposing (Month(..))
import Process
import Task
import Url exposing (Protocol(..))
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Attributes exposing (href)
import Route

-- MODEL

type Model 
    = LoadingPosts
    | PostsLoaded (List Post)

type alias Post = { title: String, date: Date, id: String }

init: (Model, Cmd Msg)
init = (LoadingPosts, httpFetchPosts) 

-- UPDATE

type Msg = 
    FetchPosts
    | PostsRetrieved (List Post)

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ = 
    case msg of
        FetchPosts -> (LoadingPosts, httpFetchPosts)
        PostsRetrieved list -> (PostsLoaded list, Cmd.none)

-- VIEW

view : Model -> Html msg
view model = div [] [
        renderPostsSection model
    ]

renderPostsSection: Model -> Html msg
renderPostsSection model =
    case model of
        PostsLoaded posts -> ol [] (List.map renderPost posts)
        LoadingPosts -> span [] [text "LoadingPosts"]

renderPost : Post -> Html msg
renderPost post = 
    let
        path = Route.pathOf (Route.BlogPost post.id)
    in
    li [] [
        a [css [marginRight (px 40)], href path] [text post.title] ,
        span [] [text (toIsoString post.date)]
    ]

-- HTTP

httpFetchPosts: Cmd Msg
httpFetchPosts =
    let
        task = Process.sleep 100
        msg = (PostsRetrieved testHomeModel)
    in
    task
        |> Task.perform (\_ -> msg)

testHomeModel : List Post
testHomeModel =  [{title = "test_1", date = fromCalendarDate 2021 Jan 1, id = "kjnhdf19084"}]
