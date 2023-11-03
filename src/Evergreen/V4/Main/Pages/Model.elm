module Evergreen.V4.Main.Pages.Model exposing (..)

import Evergreen.V4.Pages.About
import Evergreen.V4.Pages.Apps
import Evergreen.V4.Pages.Counter
import Evergreen.V4.Pages.Home_
import Evergreen.V4.Pages.NotFound_
import Evergreen.V4.Pages.Science.Champagne
import Evergreen.V4.Pages.Science.ReasonWhy
import Evergreen.V4.Pages.Scripta


type Model
    = Home_ Evergreen.V4.Pages.Home_.Model
    | About Evergreen.V4.Pages.About.Model
    | Apps Evergreen.V4.Pages.Apps.Model
    | Counter Evergreen.V4.Pages.Counter.Model
    | Photos_Paris
    | Science_Champagne Evergreen.V4.Pages.Science.Champagne.Model
    | Science_ReasonWhy Evergreen.V4.Pages.Science.ReasonWhy.Model
    | Scripta Evergreen.V4.Pages.Scripta.Model
    | NotFound_ Evergreen.V4.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
