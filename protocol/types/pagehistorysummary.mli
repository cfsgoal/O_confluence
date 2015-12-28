type t =
  { id : int option
  ; version : int option
  ; modifier : string option
  ; modified : int option
  ; versionComment : string option
  } 

include Common.Jsonable_internal with type t := t
