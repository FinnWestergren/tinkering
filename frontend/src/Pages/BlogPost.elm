module Pages.BlogPost exposing (Model, init, update, view, Msg)
import Date exposing (Date)
import Html as UnstyledHtml exposing (..)
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
import Markdown

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

view : Model -> Html.Styled.Html msg
view model = Html.Styled.div [] [
        renderPostsSection model
    ]

renderPostsSection: Model -> Html.Styled.Html msg
renderPostsSection model =
    case model of
        Loaded post -> renderPost post
        Loading -> Html.Styled.span [] [Html.Styled.text "Loading"]
        Failure -> Html.Styled.span [] [Html.Styled.text "Error"]

renderPost : Post -> Html.Styled.Html msg
renderPost post = 
    Html.Styled.div [css [marginLeft (px 20)]] [
        Html.Styled.span [css [marginRight (px 40)]] [Html.Styled.h3 [css [display inlineBlock]] [Html.Styled.text post.title]] ,
        Html.Styled.span [css [marginRight (px 40)]] [Html.Styled.h4 [css [display inlineBlock]] [Html.Styled.text post.date]],
        Html.Styled.fromUnstyled <| renderBody post.body
    ]


renderBody : String -> UnstyledHtml.Html msg
renderBody body = 
    UnstyledHtml.div []
        <| Markdown.toHtml Nothing body
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
