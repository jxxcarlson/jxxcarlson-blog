module Evergreen.V3.Pages.About exposing (..)

import Evergreen.V3.Render.Msg


type alias Model =
    { window :
        { width : Int
        , height : Int
        }
    }


type Msg
    = Render Evergreen.V3.Render.Msg.MarkupMsg
