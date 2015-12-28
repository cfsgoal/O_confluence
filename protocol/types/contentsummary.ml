open Core.Std
open Yojson

open Common

type t =
  { id : int option
  ; type_ : string option
  ; space : string option
  ; status : string option
  ; title : string option
  ; created : int option
  ; creator : string option
  ; modified : int option
  ; modifier : string option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~id:
      (get_val ~name:"id" obj to_int)
    ~type_:
      (get_val ~name:"type" obj to_string)
    ~space:
      (get_val ~name:"space" obj to_string)
    ~status:
      (get_val ~name:"status" obj to_string)
    ~title:
      (get_val ~name:"title" obj to_string)
    ~created:
      (get_val ~name:"created" obj to_int)
    ~creator:
      (get_val ~name:"creator" obj to_string)
    ~modified:
      (get_val ~name:"modified" obj to_int)
    ~modifier:
      (get_val ~name:"modifier" obj to_string)
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
    ~type_:(apply (fun i -> `String i))
    ~space:(apply (fun i -> `String i))
    ~status:(apply (fun i -> `String i))
    ~title:(apply (fun i -> `String i))
    ~created:(apply (fun i -> `Int i))
    ~creator:(apply (fun i -> `String i))
    ~modified:(apply (fun i -> `Int i))
    ~modifier:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
