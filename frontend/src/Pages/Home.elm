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
import Json.Decode exposing (Decoder)
import Json.Decode exposing (map3)
import Json.Decode exposing (list)
import Http
import Json.Decode exposing (field)
import Json.Decode exposing (string)

-- MODEL

type Model 
    = LoadingPosts
    | PostsLoaded (List PostPreview)
    | Failure

type alias PostPreview = { title: String, date: String, id: String }

init: (Model, Cmd Msg)
init = (LoadingPosts, httpFetchPosts) 

-- UPDATE

type Msg = 
    FetchPosts
    | PostsRetrieved (Result Http.Error (List PostPreview))

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ = 
    case msg of
        FetchPosts -> (LoadingPosts, httpFetchPosts)
        PostsRetrieved result ->
            case result of
                Ok posts -> (PostsLoaded posts, Cmd.none)
                _ -> (Failure, Cmd.none)

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
        Failure -> span [] [text "Error"]

renderPost : PostPreview -> Html msg
renderPost post = 
    let
        path = Route.pathOf (Route.BlogPost post.id)
    in
    li [] [
        a [css [marginRight (px 40)], href path] [text post.title] ,
        span [] [text post.date]
    ]

-- HTTP

httpFetchPosts: Cmd Msg
httpFetchPosts =
    Http.get
    { url = Debug.log "test" ("http://localhost:3000/postList")
    , expect = Http.expectJson PostsRetrieved (list postDecoder)
    }


postDecoder : Decoder PostPreview
postDecoder = 
    map3 PostPreview
    (field "title" string)
    (field "date" string)
    (field "id" string)


testHomeModel : List PostPreview
testHomeModel =  [{title = "test_1", date = "test date", id = "kjnhdf19084"}]
