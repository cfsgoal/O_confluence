open Core.Std
open Yojson

open Common

type t =
  { id : int option
  ; version : int option
  ; modifier : string option
  ; modified : int option
  ; versionComment : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~id:
      (get_val ~name:"id" obj to_int)
    ~version:
      (get_val ~name:"version" obj to_int)
    ~modifier:
      (get_val ~name:"modifier" obj to_string)
    ~modified:
      (get_val ~name:"modified" obj to_int)
    ~versionComment:
      (get_val ~name:"versionComment" obj to_string)
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
    ~version:(apply (fun i -> `Int i))
    ~modifier:(apply (fun i -> `String i))
    ~modified:(apply (fun i -> `Int i))
    ~versionComment:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
