open Core.Std
open Yojson

open Common

type t =
  { nodeId : int option
  ; jvmStats : string option
  ; props : string option
  ; buildStats : string option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~nodeId:
      (get_val ~name:"nodeId" obj to_int)
    ~jvmStats:
      (get_val ~name:"jvmStats" obj to_string)
    ~props:
      (get_val ~name:"props" obj to_string)
    ~buildStats:
      (get_val ~name:"buildStats" obj to_string)
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
    ~nodeId:(apply (fun i -> `Int i))
    ~jvmStats:(apply (fun i -> `String i))
    ~props:(apply (fun i -> `String i))
    ~buildStats:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
