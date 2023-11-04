module Evergreen.V3.Pages.Science.Champagne exposing (..)

import Evergreen.V3.Render.Msg


type alias Model =
    { window :
        { width : Int
        , height : Int
        }
    }


type Msg
    = Render Evergreen.V3.Render.Msg.MarkupMsg
