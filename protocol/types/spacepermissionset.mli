type t =
  { type_ : string option
  ; contentPermissions : Contentpermission.t list option
  } 

include Common.Jsonable_internal with type t := t
