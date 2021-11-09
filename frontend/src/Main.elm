module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Url
import Route exposing (Route)
import Pages.Home as Homepage exposing (Model)
import Pages.BlogPost as BlogPost exposing (Model)

-- MAIN

main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }

-- MODEL

type alias Model = {
    page: Page,
    navKey: Nav.Key }

type Page
  = Redirect
  | Home Homepage.Model
  | BlogPost String BlogPost.Model 
  | NotFound

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey = 
    let 
        defaultModel = { page = Redirect, navKey = navKey  }
        (model, cmd) = changePageTo defaultModel (Route.parseUrl url)
    in
        (model, cmd)

-- UPDATE

type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | HomeMsg Homepage.Msg
  | BlogPostMsg BlogPost.Msg
  | NoOp


changePageTo : Model -> Route -> ( Model, Cmd Msg )
changePageTo model route =
    case route of
    Route.NotFound -> ( { model | page = NotFound }, Cmd.none )
    Route.Home -> 
        let
            (homeModel, homeCmd) = Homepage.init
        in
            ({ model | page = Home homeModel } , Cmd.map HomeMsg homeCmd )
    Route.BlogPost id -> 
        let
            (postModel, postCmd) = BlogPost.init id
        in
            ({ model | page = BlogPost id postModel } , Cmd.map BlogPostMsg postCmd )

update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case ( message ) of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )
                Browser.External href ->
                    ( model , Nav.load href )
        UrlChanged url ->
            changePageTo model (Route.parseUrl url)
        HomeMsg msg -> 
            case model.page of
            Home homeModel -> stepHome model (Homepage.update msg homeModel)
            _         -> ( model, Cmd.none )
        BlogPostMsg msg -> 
            case model.page of
            BlogPost id postModel -> stepPost id model (BlogPost.update msg postModel)
            _         -> ( model, Cmd.none )
        _ -> ( model, Cmd.none )

-- calling this the "step" pattern because that is how the tutorials worked and it seems aight.
stepHome : Model -> ( Homepage.Model, Cmd Homepage.Msg ) -> ( Model, Cmd Msg )
stepHome model (homeModel, cmd) =
  ( { model | page = Home homeModel }
  , Cmd.map HomeMsg cmd -- "This is very rarely useful in well-structured Elm code"
  )

stepPost : String -> Model -> ( BlogPost.Model, Cmd BlogPost.Msg ) -> ( Model, Cmd Msg )
stepPost id model (postModel, cmd) =
  ( { model | page = BlogPost id postModel }
  , Cmd.map BlogPostMsg cmd -- "This is very rarely useful in well-structured Elm code"
  )
      

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW

view : Model -> Browser.Document msg
view model =
  { title = "URL Interceptor"
  , body = [toUnstyled (renderBody model)]
  }

renderBody : Model -> Html msg
renderBody model = 
        div[] [
            ul [] [ 
                viewLink Route.Home 
                ]
            , renderCurrentPage model
        ]

viewLink : Route.Route  -> Html msg
viewLink route  =
  let
    label = Route.labelOf route
    path = "/" ++ (Route.pathOf route)
  in
    li [] [ a [ href path ] [ text label ] ]

renderCurrentPage: Model -> Html msg
renderCurrentPage model = 
  case model.page of
    Home homeModel -> Homepage.view homeModel
    BlogPost _ postModel -> BlogPost.view postModel
    _ -> div [] []

routeFromCurrentPage: Model -> Route.Route
routeFromCurrentPage model =
  case model.page of
    BlogPost id _ -> Route.BlogPost id
    Home _ -> Route.Home
    _ -> Route.NotFound
