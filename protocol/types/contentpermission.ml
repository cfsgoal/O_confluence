open Core.Std
open Yojson

open Common

type t =
  { type_ : string option
  ; userName : string option
  ; groupName : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~type_:
      (get_val ~name:"type" obj to_string)
    ~userName:
      (get_val ~name:"userName" obj to_string)
    ~groupName:
      (get_val ~name:"groupName" obj to_string)
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
    ~userName:(apply (fun i -> `String i))
    ~groupName:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
