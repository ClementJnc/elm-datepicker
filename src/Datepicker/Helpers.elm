module DatePicker.Helpers exposing (defaultDate, equals, firstOfSlide, changeDay, addDay, addMonth, daysInMonth)

import Date exposing (Date, Month, fromTime, fromString, year, month, day, dayOfWeek)
import Result exposing (withDefault)
import String
import Debug


defaultDate : Date
defaultDate =
    fromTime 0


assemble : Int -> Int -> Int -> Date
assemble day month year =
    [ month, day, year ]
        |> List.map toString
        |> String.join "/"
        |> fromString
        |> Result.withDefault defaultDate


equals : Date -> Date -> Bool
equals date1 date2 =
    day date1
        == day date2
        && month date1
        == month date2
        && year date1
        == year date2


firstOfSlide : Date -> Date
firstOfSlide date =
    let
        first =
            changeDay 1 date

        prefix =
            first
                |> dayOfWeek
                |> dayAsInt
                |> (+) -1
                |> (*) -1
    in
        addDay prefix first



-- Handle days


changeDay : Int -> Date -> Date
changeDay day date =
    assemble day (monthAsInt <| month date) (year date)


addDay : Int -> Date -> Date
addDay diff date =
    let
        day0 =
            diff + (day date)

        month0 =
            month date

        daysInMonth0 =
            daysInMonth date

        daysInMonth1 =
            daysInMonth (addMonth 1 date)

        day1 =
            if day0 > (daysInMonth0 + daysInMonth1) then
                day0 - (daysInMonth0 + daysInMonth1)
            else if day0 > daysInMonth0 then
                day0 - daysInMonth0
            else if day0 < 1 then
                addMonth -1 date
                    |> daysInMonth
                    |> (+) day0
            else
                day0

        rest =
            if day0 > (daysInMonth0 + daysInMonth1) then
                addMonth 2 date
            else if day0 > daysInMonth0 then
                addMonth 1 date
            else if day0 < 1 then
                addMonth -1 date
            else
                date
    in
        assemble day1 (monthAsInt <| month rest) (year rest)



-- Handle months


addMonth : Int -> Date -> Date
addMonth diff date =
    let
        month0 =
            month date
                |> monthAsInt
                |> (+) diff

        month1 =
            if month0 > 12 then
                month0 - 12
            else if month0 < 1 then
                12 + month0
            else
                month0

        year0 =
            year date

        year1 =
            if month0 > 12 then
                year0 + 1
            else if month0 < 1 then
                year0 - 1
            else
                year0
    in
        assemble 1 month1 year1


daysInMonth : Date -> Int
daysInMonth date =
    let
        year' =
            year date

        month' =
            month date
    in
        case month' of
            Date.Feb ->
                if year' % 4 == 0 && year' % 100 /= 0 || year' % 400 == 0 then
                    29
                else
                    28

            Date.Apr ->
                30

            Date.Jun ->
                30

            Date.Sep ->
                30

            Date.Nov ->
                30

            _ ->
                31


monthAsInt : Month -> Int
monthAsInt month =
    case month of
        Date.Jan ->
            1

        Date.Feb ->
            2

        Date.Mar ->
            3

        Date.Apr ->
            4

        Date.May ->
            5

        Date.Jun ->
            6

        Date.Jul ->
            7

        Date.Aug ->
            8

        Date.Sep ->
            9

        Date.Oct ->
            10

        Date.Nov ->
            11

        Date.Dec ->
            12


dayAsInt : Date.Day -> Int
dayAsInt day =
    case day of
        Date.Mon ->
            1

        Date.Tue ->
            2

        Date.Wed ->
            3

        Date.Thu ->
            4

        Date.Fri ->
            5

        Date.Sat ->
            6

        Date.Sun ->
            7
