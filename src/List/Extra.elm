module List.Extra exposing (chunk)


chunk : Int -> List a -> List (List a)
chunk size list =
    case ( List.take size list, List.drop size list ) of
        ( [], _ ) ->
            []

        ( head, tail ) ->
            head :: chunk size tail
