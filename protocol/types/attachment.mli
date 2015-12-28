type t =
  { id : int option
  ; pageId : string option
  ; title : string option
  ; fileName : string option
  ; fileSize : string option
  ; contentType : string option
  ; created : int option
  ; creator : string option
  ; url : string option
  ; comment : string option
  } 

include Common.Jsonable_internal with type t := t
