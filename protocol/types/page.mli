type t =
  { id : int option
  ; space : string option
  ; parentId : int option
  ; title : string option
  ; url : string option
  ; version : int option
  ; content : string option
  ; created : int option
  ; creator : string option
  ; modified : int option
  ; modifier : string option
  ; homePage : bool option
  ; permissions : int option
  ; contentStatus : string option
  ; current : bool option
  } 

include Common.Jsonable_internal with type t := t
