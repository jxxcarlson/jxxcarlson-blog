module Evergreen.V2.Pages.Science.Champagne exposing (..)

import Evergreen.V2.Render.Msg


type alias Model =
    { window :
        { width : Int
        , height : Int
        }
    }


type Msg
    = Render Evergreen.V2.Render.Msg.MarkupMsg
