module HomeTest exposing (suite)

import Expect
import Fuzz exposing (intRange)
import Test exposing (..)
import Pages.Home as Home
import Html.Styled exposing (..)
import Date exposing (Interval(..), Unit(..), toIsoString, fromCalendarDate)
import Time exposing (Month(..), Weekday(..))
import List exposing (repeat)
import Html.Styled.Attributes exposing (href)
import Html.Styled.Attributes exposing (css)
import Css exposing (marginRight)
import Css exposing (px)

suite : Test
suite =
    describe "The Homepage Module"
        [ fuzz (intRange 1900 2300) "renders single post" <|
            \num -> 
                let
                    title = (String.fromInt num) ++ "test"
                    date = fromCalendarDate num Sep 26
                    id = String.fromInt (num * num)
                    post = {title = title, date = date, id = id}
                    expected = li [] [
                        a [css [marginRight (px 40)], href ("Post/" ++ id)] [text title],
                        span [] [text (toIsoString date)]]
                in
                Home.renderPost post
                |> Expect.equal expected,
            fuzz (intRange 1 20) "renders multiple posts" <|
            \num -> 
                let
                    title = "test"
                    date = fromCalendarDate 2020 Oct 26
                    post = {title = title, date = date, id = String.fromInt (num * num)}
                    posts = post |> repeat num
                    multi = post |> Home.renderPost |> repeat num 
                    expected = div [] [ol [] multi]
                    
                in
                    Home.view (Home.PostsLoaded posts)
                |> Expect.equal expected
        ]
