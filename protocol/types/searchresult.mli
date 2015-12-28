type t =
  { title : string option
  ; url : string option
  ; excerpt : string option
  ; type_: string option
  ; id : int option
  } 

include Common.Jsonable_internal with type t := t
