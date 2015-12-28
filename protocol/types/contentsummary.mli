type t =
  { id : int option
  ; type_ : string option
  ; space : string option
  ; status : string option
  ; title : string option
  ; created : int option
  ; creator : string option
  ; modified : int option
  ; modifier : string option
  } 

include Common.Jsonable_internal with type t := t
