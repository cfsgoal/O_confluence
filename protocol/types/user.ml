open Core.Std
open Yojson

open Common

type t =
  { name : string option
  ; fullname : string option
  ; email : string option
  ; url : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~name:
      (get_val ~name:"name" obj to_string)
    ~fullname:
      (get_val ~name:"fullname" obj to_string)
    ~email:
      (get_val ~name:"email" obj to_string)
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
    ~name:(apply (fun i -> `String i))
    ~fullname:(apply (fun i -> `String i))
    ~email:(apply (fun i -> `String i))
    ~url:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
