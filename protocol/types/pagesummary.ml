open Core.Std
open Yojson

open Common

type t =
  { id : int option
  ; space : string option
  ; parentId : int option
  ; title : string option
  ; url : string option
  ; permissions : int option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~id:
      (get_val ~name:"id" obj to_int)
    ~space:
      (get_val ~name:"space" obj to_string)
    ~parentId:
      (get_val ~name:"parentId" obj to_int)
    ~title:
      (get_val ~name:"title" obj to_string)
    ~url:
      (get_val ~name:"url" obj to_string)
    ~permissions:
      (get_val ~name:"permissions" obj to_int)
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
    ~id:(apply (fun i -> `Int i))
    ~space:(apply (fun i -> `String i))
    ~parentId:(apply (fun i -> `Int i))
    ~title:(apply (fun i -> `String i))
    ~url:(apply (fun i -> `String i))
    ~permissions:(apply (fun i -> `Int i))
  |> fun ls -> `Assoc (List.rev ls)
