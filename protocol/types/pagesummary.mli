type t =
  { id : int option
  ; space : string option
  ; parentId : int option
  ; title : string option
  ; url : string option
  ; permissions : int option
  } 

include Common.Jsonable_internal with type t := t
