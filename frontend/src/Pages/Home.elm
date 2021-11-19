module Pages.Home exposing (init, update, view, Msg, renderPost, Model(..))
import Html exposing (..)
import Html.Attributes exposing (href)
import Http
import Json.Decode exposing (..)
import List
import Route
import Url exposing (Protocol(..))
import Html.Attributes exposing (src)
import Html.Attributes exposing (class)

-- MODEL

type Model 
    = LoadingPosts
    | PostsLoaded (List PostListItem)
    | Failure

type alias PostListItem = { title: String, date: String, id: String }

init: String -> (Model, Cmd Msg)
init serverAddress = (LoadingPosts, httpFetchPosts serverAddress) 

-- UPDATE

type Msg = 
    PostsRetrieved (Result Http.Error (List PostListItem))

update : Msg -> Model -> (Model, Cmd Msg)
update msg _ = 
    case msg of
        PostsRetrieved result ->
            case result of
                Ok posts -> (PostsLoaded posts, Cmd.none)
                _ -> (Failure, Cmd.none)

-- VIEW

view : Model -> String -> Html msg
view model serverAddress = div [] [
        renderPostsSection model serverAddress
    ]

renderPostsSection: Model -> String -> Html msg
renderPostsSection model serverAddress =
    case model of
        PostsLoaded posts -> div [class "post-list"] (List.indexedMap (\i p -> renderPost p serverAddress (i + 1)) posts)
        LoadingPosts -> span [] [text "LoadingPosts"]
        Failure -> span [] [text "Error"]

renderPost : PostListItem ->  String -> Int -> Html msg
renderPost post serverAddress index = 
    let
        path = Route.pathOf (Route.BlogPost post.id)
        imgList = renderIndexImage serverAddress index
    in
    div [class "post-li"] [
        div [class "img-prefix"] imgList, 
        a [href path] [text post.title] ,
        span [] [text post.date]
    ]


renderIndexImage : String -> Int -> List(Html msg)
renderIndexImage serverAddress index =
    let
        imgsrc = serverAddress ++ "/img/numbers/" ++ String.fromInt (modBy 10 index)
        image = img [src imgsrc] []

        nextlist = if index >= 10 
            then renderIndexImage serverAddress (index // 10) 
            else []
    in
    List.append nextlist [image]
-- HTTP

httpFetchPosts: String -> Cmd Msg
httpFetchPosts serverAddress = 
    Http.get
    { url = serverAddress ++ "/postList"
    , expect = Http.expectJson PostsRetrieved (list postDecoder)
    }


postDecoder : Decoder PostListItem
postDecoder = 
    map3 PostListItem
    (field "title" string)
    (field "date" string)
    (field "id" string)
