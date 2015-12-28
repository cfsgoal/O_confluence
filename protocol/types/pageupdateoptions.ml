open Core.Std
open Yojson

open Common

type t =
  { versionComment : string option
  ; minorEdit : bool option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~versionComment:
      (get_val ~name:"versionComment" obj to_string)
    ~minorEdit:
      (get_val ~name:"minorEdit" obj to_bool)
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
    ~versionComment:(apply (fun i -> `String i))
    ~minorEdit:(apply (fun i -> `Bool i))
  |> fun ls -> `Assoc (List.rev ls)
