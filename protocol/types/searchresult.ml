open Core.Std
open Yojson

open Common

type t =
  { title : string option
  ; url : string option
  ; excerpt : string option
  ; type_: string option
  ; id : int option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~title:
      (get_val ~name:"title" obj to_string)
    ~url:
      (get_val ~name:"url" obj to_string)
    ~excerpt:
      (get_val ~name:"excerpt" obj to_string)
    ~type_:
      (get_val ~name:"type" obj to_string)
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
    ~title:(apply (fun i -> `String i))
    ~url:(apply (fun i -> `String i))
    ~excerpt:(apply (fun i -> `String i))
    ~type_:(apply (fun i -> `String i))
    ~id:(apply (fun i -> `Int i))
  |> fun ls -> `Assoc (List.rev ls)
