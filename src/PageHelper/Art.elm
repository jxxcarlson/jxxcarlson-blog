module PageHelper.Art exposing (..)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Geometry
import Render.Msg
import Scripta


article : Document -> { width : Int, height : Int } -> Element Render.Msg.MarkupMsg
article document window =
    column [ spacing 36, paddingXY 24 24, Background.color Color.black, Font.color Color.white ]
        [ title document.title
        , header window document
        , element window document.content
        ]


element window src =
    row [ centerX, Background.color Color.white, Font.color Color.black ]
        [ Scripta.katexCSS
        , Scripta.display window src
        ]


header : { width : Int, height : Int } -> Document -> Element msg
header window doc =
    case
        doc.contentHeader
    of
        Just str ->
            splitHeader window doc str

        Nothing ->
            imageHeader window doc


splitHeader : { width : Int, height : Int } -> Document -> String -> Element msg
splitHeader window doc str =
    row [ spacing 12 ]
        [ image [ width (px 300) ] { src = doc.imageUrl, description = doc.imageDescription }
        , column [ width (px 300), alignTop ]
            [ column [ Font.size 14, spacing 12 ] (compile str)
            ]
        ]


imageHeader : { width : Int, height : Int } -> Document -> Element msg
imageHeader window doc =
    image [ width (px <| Geometry.scale 1.4 (Geometry.articleWidth window)) ] { src = doc.imageUrl, description = doc.imageDescription }


type alias Document =
    { title : String
    , imageUrl : String
    , imageDescription : String
    , contentHeader : Maybe String
    , content : String
    }


title : String -> Element msg
title str =
    el [ Font.size 24 ] (Element.text str)


compile : String -> List (Element msg)
compile str =
    List.map transform (String.split "\n\n" str)


transform : String -> Element msg
transform str =
    if String.left 12 str == "@subheading " then
        paragraph [ Font.bold ] [ Element.text (String.dropLeft 12 str) ]

    else
        paragraph [] [ Element.text str ]
