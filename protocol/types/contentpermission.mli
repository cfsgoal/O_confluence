type t =
  { type_ : string option
  ; userName : string option
  ; groupName : string option
  } 

include Common.Jsonable_internal with type t := t
