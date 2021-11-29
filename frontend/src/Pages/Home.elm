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
import Html.Attributes exposing (style)
import Array

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
        itemBackground = renderItemBackground serverAddress
        dateImage = renderDateImage serverAddress post.date 
    in
    div [class "post-li"] [
        span [class "post-date"] dateImage,
        span [class "item-background-wrapper"] [itemBackground],
        a [href path, class "item-title"] [text post.title]
    ]


renderDateImage : String -> String -> List(Html msg) 

renderDateImage serverAddress dateString =
    let
        parts = Array.fromList <| String.split " " dateString
        month = Maybe.withDefault "Jan" <| Array.get 0 parts
        monthImage = renderMonthImage serverAddress month
        day = Maybe.withDefault "1" <| Array.get 1 parts
        dayImage = renderNumberImage serverAddress <| Maybe.withDefault 1 <| String.toInt day
        year = Maybe.withDefault "2001" <| Array.get 2 parts
        yearImage = renderNumberImage serverAddress <| Maybe.withDefault 1 <| String.toInt year
    in
    [span [style "margin-right" "5"][monthImage], span [style "margin-right" "5"] dayImage, span [] yearImage]


renderNumberImage : String -> Int -> List(Html msg)
renderNumberImage serverAddress value =
    let
        imgsrc = serverAddress ++ "/img/numbers/" ++ String.fromInt (modBy 10 value)
        image = img [src imgsrc] []

        nextlist = if value >= 10 
            then renderNumberImage serverAddress (value // 10) 
            else []
    in
    List.append nextlist [image]

renderMonthImage : String -> String -> Html msg
renderMonthImage serverAddress value =
    let
        imgsrc = serverAddress ++ "/img/months/" ++ value
    in
    img [src imgsrc] []

renderItemBackground : String -> Html msg
renderItemBackground  serverAddress =
    let
        imgsrc = serverAddress ++ "/img/list-item-background"
    in
    img [src imgsrc] []


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
