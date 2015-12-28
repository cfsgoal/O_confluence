open Core.Std
open Yojson

open Common

type t =
  { id : int option
  ; pageId : string option
  ; title : string option
  ; content : string option
  ; url : string option
  ; created : int option
  ; creator : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~id:
      (get_val ~name:"id" obj to_int)
    ~pageId:
      (get_val ~name:"pageId" obj to_string)
    ~title:
      (get_val ~name:"title" obj to_string)
    ~content:
      (get_val ~name:"content" obj to_string)
    ~url:
      (get_val ~name:"url" obj to_string)
    ~created:
      (get_val ~name:"created" obj to_int)
    ~creator:
      (get_val ~name:"creator" obj to_string)
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
    ~pageId:(apply (fun i -> `String i))
    ~title:(apply (fun i -> `String i))
    ~content:(apply (fun i -> `String i))
    ~url:(apply (fun i -> `String i))
    ~created:(apply (fun i -> `Int i))
    ~creator:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
