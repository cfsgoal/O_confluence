type t =
  { key : string option
  ; name : string option
  ; url : string option
  ; homePage : int option
  ; description : string option
  } 

include Common.Jsonable_internal with type t := t
