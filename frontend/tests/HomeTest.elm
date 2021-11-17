module HomeTest exposing (suite)

import Expect
import Html exposing (..)
import Fuzz exposing (intRange)
import Test exposing (..)
import Pages.Home as Home
import List exposing (repeat)
import Html.Attributes exposing (href)

suite : Test
suite =
    describe "The Homepage Module"
        [ fuzz (intRange 1900 2300) "renders single post" <|
            \num -> 
                let
                    title = (String.fromInt num) ++ "test"
                    date = "Sep 26"
                    id = String.fromInt (num * num)
                    post = {title = title, date = date, id = id}
                    expected = li [] [
                        a [href ("Post/" ++ id)] [text title],
                        span [] [text date]]
                in
                Home.renderPost post
                |> Expect.equal expected,
            fuzz (intRange 1 20) "renders multiple posts" <|
            \num -> 
                let
                    title = "test"
                    date = "2020 Oct 26"
                    post = {title = title, date = date, id = String.fromInt (num * num)}
                    posts = post |> repeat num
                    multi = post |> Home.renderPost |> repeat num 
                    expected = div [] [ol [] multi]
                    
                in
                    Home.view (Home.PostsLoaded posts)
                |> Expect.equal expected
        ]
