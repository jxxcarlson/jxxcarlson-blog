module Shared.Msg exposing (Msg(..))

import Browser.Dom
import Ports
import Render.Msg exposing (MarkupMsg)


{-| Normally, this value would live in "Shared.elm"
but that would lead to a circular dependency import cycle.

For that reason, both `Shared.Model` and `Shared.Msg` are in their
own file, so they can be imported by `Effect.elm`

-}
type Msg
    = GotNewSmashedLikes Int
    | WindowResized Int Int
    | Render MarkupMsg
    | DimensionsChanged Ports.Dimensions
    | GotViewport Browser.Dom.Viewport
