type t =
  { name : string option
  ; fullname : string option
  ; email : string option
  ; url : string option
  } 

include Common.Jsonable_internal with type t := t
