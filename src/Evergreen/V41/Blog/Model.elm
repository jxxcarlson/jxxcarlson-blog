module Evergreen.V41.Blog.Model exposing (..)


type alias Model =
    { window :
        { width : Int
        , height : Int
        }
    , routeString : String
    }