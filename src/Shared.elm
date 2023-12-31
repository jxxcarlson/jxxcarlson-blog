module Shared exposing
    ( Flags, decoder
    , Model, Msg
    , init, update, subscriptions
    )

{-|

@docs Flags, decoder
@docs Model, Msg
@docs init, update, subscriptions

-}

import Browser.Dom as Dom
import Browser.Events
import Effect exposing (Effect)
import Json.Decode
import Process
import Route exposing (Route)
import Route.Path
import Shared.Model
import Shared.Msg
import Task


type alias Model =
    Shared.Model.Model



-- FLAGS


type alias Flags =
    { width : Int, height : Int }


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.map2 Flags
        (Json.Decode.field "width" Json.Decode.int)
        (Json.Decode.field "height" Json.Decode.int)



-- INIT


init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init flagsResult route =
    let
        flags : Flags
        flags =
            case flagsResult of
                Ok value ->
                    value

                Err reason ->
                    { width = 1424
                    , height = 790
                    }
    in
    ( { smashedLikes = 0
      , dimensions =
            { width = flags.width
            , height = flags.height
            }
                |> Debug.log "@@SHARED_INIT"
      }
    , setupWindow
    )



-- UPDATE


type alias Msg =
    Shared.Msg.Msg


update : Route () -> Msg -> Model -> ( Model, Effect Msg )
update route msg model =
    case msg of
        Shared.Msg.GotNewSmashedLikes count ->
            ( { model | smashedLikes = count }
            , Effect.none
            )

        Shared.Msg.WindowResized width height ->
            ( { model
                | dimensions = { width = width, height = height } |> Debug.log "@@@!RESIZED"
              }
            , Effect.none
            )

        Shared.Msg.Render _ ->
            ( model, Effect.none )

        Shared.Msg.DimensionsChanged dimensions ->
            ( { model | dimensions = { height = dimensions.height, width = dimensions.width } }
            , Effect.none
            )

        Shared.Msg.GotViewport vp ->
            let
                w =
                    round vp.viewport.width

                h =
                    round vp.viewport.height
            in
            ( { model
                | dimensions = { width = w, height = h } |> Debug.log "@@@!DIMENSIONS_VIA_VIEWPORT"
              }
            , Effect.none
            )


setupWindow : Effect Shared.Msg.Msg
setupWindow =
    -- Task.perform Shared.Msg.GotViewport Dom.getViewport |> Effect.sendCmd
    Task.perform Shared.Msg.GotViewport viewportTask |> Effect.sendCmd


viewportTask : Task.Task x Dom.Viewport
viewportTask =
    Process.sleep 40 |> Task.andThen (\_ -> Dom.getViewport)


foo : Task.Task x Dom.Viewport
foo =
    Dom.getViewport



-- SUBSCRIPTIONS


subscriptions : Route () -> Model -> Sub Msg
subscriptions route model =
    Browser.Events.onResize Shared.Msg.WindowResized
