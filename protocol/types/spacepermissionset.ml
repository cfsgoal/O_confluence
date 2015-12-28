open Core.Std
open Yojson

open Common

type t =
  { type_ : string option
  ; contentPermissions : Contentpermission.t list option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~type_:
      (get_val ~name:"type" obj to_string)
    ~contentPermissions:
      (get_val
         ~name:"contentPermissions"
         obj
         (convert_each Contentpermission.Internal.of_json)
      )
end

let of_json obj = Internal.of_json (Safe.to_basic obj)

let (to_json : t -> Safe.json) t =
  let apply to_json acc fld =
    match Field.get fld t with
    | Some val_ -> (Field.name fld, to_json val_)::acc
    | None -> acc
  in
  Fields.fold
    ~init:[]
    ~type_:(apply (fun i -> `String i))
    ~contentPermissions:(apply (fun i ->
        List.map ~f:Contentpermission.to_json i
        |> fun l -> `List l))
  |> fun ls -> `Assoc (List.rev ls)
