module HomeTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Pages.Home as Home exposing (Model, renderPost)
import Html exposing (div, ol, li, text)
import Date exposing (Date, Interval(..), Unit(..), toIsoString, fromCalendarDate)
import Time exposing (Month(..), Weekday(..))

suite : Test
suite =
    describe "The Homepage Module"
        [ fuzz string "renders single post" <|
            \str -> 
                let
                    date = toIsoString (fromCalendarDate 2018 Sep 26)
                    post = {title = str}
                    expected = li [] [
                        div[] [text str],
                        div[] [text date]]
                in
                    Home.renderPost post
                |> Expect.equal expected
        ]