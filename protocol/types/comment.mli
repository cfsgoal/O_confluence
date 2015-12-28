type t =
  { id : int option
  ; pageId : string option
  ; title : string option
  ; content : string option
  ; url : string option
  ; created : int option
  ; creator : string option
  } 

include Common.Jsonable_internal with type t := t
