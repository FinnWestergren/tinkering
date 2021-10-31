module Pages.Home exposing (..)
import Html exposing (ol, Html, div, text, li, ol, span)
import List exposing (map)
import Date exposing (Date, toIsoString, fromCalendarDate)
import Time exposing (Month(..))
import Process
import Task
import Url exposing (Protocol(..))

-- MODEL

type Model 
    = LoadingPosts
    | PostsLoaded (List Post)

type alias Post = { title: String, date: Date }

init: (Model, Cmd Msg)
init = (LoadingPosts, httpFetchPosts) 


testHomeModel : List Post
testHomeModel =  [
        {title = "test_1", date = fromCalendarDate 2020 Jan 1 },
        {title = "test_2", date = fromCalendarDate 2020 Feb 2 },
        {title = "test_3", date = fromCalendarDate 2020 Mar 3 },
        {title = "test_4", date = fromCalendarDate 2020 Apr 4 },
        {title = "test_5", date = fromCalendarDate 2020 May 5 },
        {title = "test_6", date = fromCalendarDate 2020 Jun 6 },
        {title = "test_7", date = fromCalendarDate 2020 Jul 7 }]

-- UPDATE

type Msg = 
    FetchPosts
    | PostsRetrieved (List Post)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        FetchPosts -> (LoadingPosts, httpFetchPosts)
        PostsRetrieved list -> (PostsLoaded list, Cmd.none)

-- VIEW

view : Model -> Html msg
view model = div []
    [renderPostsSection model]

renderPostsSection: Model -> Html msg
renderPostsSection model =
    case model of
        PostsLoaded posts -> ol [] (map renderPost posts)
        LoadingPosts -> span [] [text "LoadingPosts"]

renderPost : Post -> Html msg
renderPost post = 
    li [] [
        span [] [text post.title],
        span [] [text (toIsoString post.date)]
    ]

-- HTTP

httpFetchPosts: Cmd Msg
httpFetchPosts =
    let
        task = Process.sleep 2000
        msg = (PostsRetrieved testHomeModel)
    in
    task
        |> Task.perform (\_ -> msg)