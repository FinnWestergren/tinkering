module HomeTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Pages.Home as Home exposing (Model, view)
import Html exposing (div)
import Html exposing (ol)
import Html exposing (li)
import Html exposing (text)

suite : Test
suite =
    describe "The Homepage Module"
        [ fuzz string "renders post titles" <|
            \str -> 
                let
                    model = { posts = [ {title = str }] }
                    expected = div []
                        [ol [] 
                            [li [] [text str]]
                        ]
                in
                    Home.view model
                |> Expect.equal expected
        ]