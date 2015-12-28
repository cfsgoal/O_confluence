type t =
  { nodeId : int option
  ; jvmStats : string option
  ; props : string option
  ; buildStats : string option
  } 

include Common.Jsonable_internal with type t := t
