type t =
  { majorVersion     : int option
  ; minorVersion     : int option
  ; patchLevel       : int option
  ; buildId          : string option
  ; developmentBuild : bool option
  ; baseUrl          : string option
  } 

include Common.Jsonable_internal with type t := t
