module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Route exposing (Route)
import Session exposing (Session)
import Html.Events exposing (onClick)
import Pages.Home as Homepage exposing (Model)


type alias Flags =
    {}

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

type Model 
  = Home Session Homepage.Model
  | EntryEditor Session
  | NotFound Session 
  


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey = changeRouteTo (Route.parseUrl url) (Home (Session.toSession navKey))
--({ key = navKey, page = Route.parseUrl url } , Cmd.none)

-- UPDATE

type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | Log String

changeRouteTo : Route -> Model -> ( Model, Cmd Msg )
changeRouteTo route model =
  let
    session = toSession model
  in
    case route of
    Route.NotFound -> ( NotFound session, Cmd.none )
    Route.Home -> ( Home session, Cmd.none )
    Route.EntryEditor -> ( EntryEditor session, Cmd.none)

toSession : Model -> Session
toSession page =
    case page of
        NotFound session ->
            session
        Home session ->
            session
        EntryEditor session ->
            session

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    let
                      navKey = Session.navKey (toSession model)
                    in
                    ( model, Nav.pushUrl navKey (Url.toString url) )
                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( UrlChanged url, _ ) ->
            changeRouteTo (Route.parseUrl url) model
        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )
      

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW

view : Model -> Browser.Document Msg
view model =
  { title = "URL Interceptor"
  , body =
      [ text "The current page is: "
      , b [] [ text (Route.labelOf (routeFromCurrentPage model)) ]
      , ul []
          [ viewLink Route.EntryEditor
          , viewLink Route.Home ]
      ]
  }


viewLink : Route.Route  -> Html msg
viewLink route  =
  let
    label = Route.labelOf route
    path = "/" ++ (Route.pathOf route)
  in
   li [] [ a [ href path ] [ text label ] ]

routeFromCurrentPage: Model -> Route.Route
routeFromCurrentPage model =
  case model of
    NotFound _ -> Route.NotFound
    EntryEditor _ -> Route.EntryEditor
    Home _ -> Route.Home