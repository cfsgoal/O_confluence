type t =
  { totalAvailable : int option
  ; offset : int option
  ; content : Contentsummary.t list option
  } 

include Common.Jsonable_internal with type t := t
