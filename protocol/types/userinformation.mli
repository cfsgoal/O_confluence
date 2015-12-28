type t =
  { username : string option
  ; content : string option
  ; creatorName : string option
  ; lastModifierName : string option
  ; version : int option
  ; id : int option
  ; creationDate : int option
  ; lastModificationDate : int option
  } 

include Common.Jsonable_internal with type t := t
