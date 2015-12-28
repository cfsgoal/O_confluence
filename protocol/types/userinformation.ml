open Core.Std
open Yojson

open Common

type t =
  { username : string option
  ; content : string option
  ; creatorName : string option
  ; lastModifierName : string option
  ; version : int option
  ; id : int option
  ; creationDate : int option
  ; lastModificationDate : int option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~username:
      (get_val ~name:"username" obj to_string)
    ~content:
      (get_val ~name:"content" obj to_string)
    ~creatorName:
      (get_val ~name:"creatorName" obj to_string)
    ~lastModifierName:
      (get_val ~name:"lastModifierName" obj to_string)
    ~version:
      (get_val ~name:"version" obj to_int)
    ~id:
      (get_val ~name:"id" obj to_int)
    ~creationDate:
      (get_val ~name:"creationDate" obj to_int)
    ~lastModificationDate:
      (get_val ~name:"lastModificationDate" obj to_int)
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
    ~username:(apply (fun i -> `String i))
    ~content:(apply (fun i -> `String i))
    ~creatorName:(apply (fun i -> `String i))
    ~lastModifierName:(apply (fun i -> `String i))
    ~version:(apply (fun i -> `Int i))
    ~id:(apply (fun i -> `Int i))
    ~creationDate:(apply (fun i -> `Int i))
    ~lastModificationDate:(apply (fun i -> `Int i))
  |> fun ls -> `Assoc (List.rev ls)
