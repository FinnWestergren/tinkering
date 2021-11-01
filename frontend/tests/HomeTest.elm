module HomeTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange)
import Test exposing (..)
import Pages.Home as Home exposing (Model, renderPost)
import Html.Styled exposing (..)
import Date exposing (Date, Interval(..), Unit(..), toIsoString, fromCalendarDate)
import Time exposing (Month(..), Weekday(..))
import List exposing (repeat)

suite : Test
suite =
    describe "The Homepage Module"
        [ fuzz (intRange 1900 2300) "renders single post" <|
            \num -> 
                let
                    title = (String.fromInt num) ++ "test"
                    date = fromCalendarDate num Sep 26
                    post = {title = title, date = date}
                    expected = li [] [
                        span [] [text title],
                        span [] [text (toIsoString date)]]
                in
                    Home.renderPost post
                |> Expect.equal expected,
            fuzz (intRange 1 20) "renders multiple posts" <|
            \num -> 
                let
                    title = "test"
                    date = fromCalendarDate 2020 Oct 26
                    post = {title = title, date = date}
                    posts = post |> repeat num
                    multi = post |> Home.renderPost |> repeat num 
                    expected = div [] [ol [] multi]
                    
                in
                    Home.view (Home.PostsLoaded posts)
                |> Expect.equal expected
        ]