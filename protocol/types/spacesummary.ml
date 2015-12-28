open Core.Std
open Yojson

open Common

type t =
  { key : string option
  ; name : string option
  ; type_ : string option
  ; url : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~key:
      (get_val ~name:"key" obj to_string)
    ~name:
      (get_val ~name:"name" obj to_string)
    ~type_:
      (get_val ~name:"type" obj to_string)
    ~url:
      (get_val ~name:"url" obj to_string)
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
    ~key:(apply (fun i -> `String i))
    ~name:(apply (fun i -> `String i))
    ~type_:(apply (fun i -> `String i))
    ~url:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
