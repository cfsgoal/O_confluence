type t =
  { isRunning : bool option
  ; name : string option
  ; numberCount : int option
  ; description : string option
  ; multicastAddress : string option
  ; multicastPort : string option
  } 

include Common.Jsonable_internal with type t := t
