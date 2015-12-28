type t =
  { id : int option
  ; space : string option
  ; title : string option
  ; url : string option
  ; permissions : int option
  ; publishDate : int option
  } 

include Common.Jsonable_internal with type t := t
