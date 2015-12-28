open Core.Std
open Yojson

open Common

type t =
  { totalAvailable : int option
  ; offset : int option
  ; content : Contentsummary.t list option
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create
    ~totalAvailable:
      (get_val ~name:"totalAvailable" obj to_int)
    ~offset:
      (get_val ~name:"offset" obj to_int)
    ~content:
      (get_val
         ~name:"content"
         obj
         (convert_each Contentsummary.Internal.of_json)
      )
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
    ~totalAvailable:(apply (fun i -> `Int i))
    ~offset:(apply (fun i -> `Int i))
    ~content:(apply (fun i ->
        List.map ~f:Contentsummary.to_json i
        |> fun l -> `List l))
  |> fun ls -> `Assoc (List.rev ls)
