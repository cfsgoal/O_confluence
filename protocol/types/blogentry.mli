type t =
  { id : int option
  ; space : string option
  ; title : string option
  ; url : string option
  ; version : int option
  ; content : string option
  ; permissions : int option
  } 

include Common.Jsonable_internal with type t := t
