open Core.Std
open Yojson

open Common

type t =
  { majorVersion     : int option
  ; minorVersion     : int option
  ; patchLevel       : int option
  ; buildId          : string option
  ; developmentBuild : bool option
  ; baseUrl          : string option
  } with fields,sexp

module Internal = struct
let of_json obj =
  let open Basic.Util in
  Fields.create
    ~majorVersion:
      (get_val ~name:"majorVersion" obj to_int)
    ~minorVersion:
      (get_val ~name:"minorVersion" obj to_int)
    ~patchLevel:
      (get_val ~name:"patchLevel" obj to_int)
    ~buildId:
      (get_val ~name:"buildId" obj to_string)
    ~developmentBuild:
      (get_val ~name:"developmentBuild" obj to_bool)
    ~baseUrl:
      (get_val ~name:"baseUrl" obj to_string)
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
    ~majorVersion:(apply (fun i -> `Int i))
    ~minorVersion:(apply (fun i -> `Int i))
    ~patchLevel:(apply (fun i -> `Int i))
    ~buildId:(apply (fun s -> `String s))
    ~developmentBuild:(apply (fun b -> `Bool b))
    ~baseUrl:(apply (fun s -> `String s))
  |> fun ls -> `Assoc (List.rev ls)
