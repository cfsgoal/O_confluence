type t =
  { versionComment : string option
  ; minorEdit : bool option
  } 

include Common.Jsonable_internal with type t := t
