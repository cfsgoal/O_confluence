open Core.Std
open Yojson

open Common

type t =
  { name : string option
  ; owner : string option
  ; namespace : string option
  ; id : int option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~name:
      (get_val ~name:"name" obj to_string)
    ~owner:
      (get_val ~name:"owner" obj to_string)
    ~namespace:
      (get_val ~name:"namespace" obj to_string)
    ~id:
      (get_val ~name:"id" obj to_int)
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
    ~owner:(apply (fun i -> `String i))
    ~namespace:(apply (fun i -> `String i))
    ~id:(apply (fun i -> `Int i))
  |> fun ls -> `Assoc (List.rev ls)
