open Core.Std
open Yojson

open Common

type t =
  { isRunning : bool option
  ; name : string option
  ; numberCount : int option
  ; description : string option
  ; multicastAddress : string option
  ; multicastPort : string option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~isRunning:
      (get_val ~name:"isRunning" obj to_bool)
    ~name:
      (get_val ~name:"name" obj to_string)
    ~numberCount:
      (get_val ~name:"numberCount" obj to_int)
    ~description:
      (get_val ~name:"description" obj to_string)
    ~multicastAddress:
      (get_val ~name:"multicastAddress" obj to_string)
    ~multicastPort:
      (get_val ~name:"multicastPort" obj to_string)
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
    ~isRunning:(apply (fun i -> `Bool i))
    ~name:(apply (fun i -> `String i))
    ~numberCount:(apply (fun i -> `Int i))
    ~description:(apply (fun i -> `String i))
    ~multicastAddress:(apply (fun i -> `String i))
    ~multicastPort:(apply (fun i -> `String i))
  |> fun ls -> `Assoc (List.rev ls)
