module DatePicker.Config exposing (..)

{-| Configuration for the date picker.

The configuration should **not** appear in your model.

# Definitions
@docs Config

# Helpers
@docs defaultConfig, setDefaultDate, setGetClasses, setUseDefaultStyles, setUseRange
-}

-- TODO: rename defaultConfig to datePickerConfig and move to DatePicker module
-- TODO: remove the setXXX helper methods

import Date exposing (Date)
import DatePicker.Style as Style
import DatePicker.Helpers as Helpers


{-| The configuration for a date picker.
-}
type alias Config =
    { getClasses : Style.View -> List ( String, Bool )
    , useDefaultStyles : Bool
    , defaultDate : Date
    , useRange : Bool
    , placeholderFrom : String
    , placeholderTo : String
    }


{-| Update a configuration to use the specified function to control the styling.
-}
setGetClasses : (Style.View -> List ( String, Bool )) -> Config -> Config
setGetClasses getClasses config =
    { config | getClasses = getClasses }


{-| Update whether a configuration should use the default styles.
-}
setUseDefaultStyles : Bool -> Config -> Config
setUseDefaultStyles useDefaultStyles config =
    { config | useDefaultStyles = useDefaultStyles }


{-| Update a configuration to use the specified default date.
-}
setDefaultDate : Date -> Config -> Config
setDefaultDate defaultDate config =
    { config | defaultDate = defaultDate }


{-| Update a configuration to select either a range or a single date.
-}
setUseRange : Bool -> Config -> Config
setUseRange useRange config =
    { config | useRange = useRange }


{-|
-}
defaultConfig : Config
defaultConfig =
    { getClasses = always []
    , useDefaultStyles = True
    , defaultDate = Helpers.defaultDate
    , useRange = False
    , placeholderFrom = "From"
    , placeholderTo = "To"
    }
