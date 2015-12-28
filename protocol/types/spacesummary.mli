type t =
  { key : string option
  ; name : string option
  ; type_ : string option
  ; url : string option
  } 

include Common.Jsonable_internal with type t := t
