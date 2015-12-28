type t =
  { name : string option
  ; owner : string option
  ; namespace : string option
  ; id : int option
  } 

include Common.Jsonable_internal with type t := t
