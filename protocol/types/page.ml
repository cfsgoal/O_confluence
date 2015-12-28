open Core.Std
open Yojson

open Common

type t =
  { id : int option
  ; space : string option
  ; parentId : int option
  ; title : string option
  ; url : string option
  ; version : int option
  ; content : string option
  ; created : int option
  ; creator : string option
  ; modified : int option
  ; modifier : string option
  ; homePage : bool option
  ; permissions : int option
  ; contentStatus : string option
  ; current : bool option
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
    ~version:
      (get_val ~name:"version" obj to_int)
    ~content:
      (get_val ~name:"content" obj to_string)
    ~created:
      (get_val ~name:"created" obj to_int)
    ~creator:
      (get_val ~name:"creator" obj to_string)
    ~modified:
      (get_val ~name:"modified" obj to_int)
    ~modifier:
      (get_val ~name:"modifier" obj to_string)
    ~homePage:
      (get_val ~name:"homePage" obj to_bool)
    ~permissions:
      (get_val ~name:"permissions" obj to_int)
    ~contentStatus:
      (get_val ~name:"contentStatus" obj to_string)
    ~current:
      (get_val ~name:"current" obj to_bool)
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
    ~version:(apply (fun i -> `Int i))
    ~content:(apply (fun i -> `String i))
    ~created:(apply (fun i -> `Int i))
    ~creator:(apply (fun i -> `String i))
    ~modified:(apply (fun i -> `Int i))
    ~modifier:(apply (fun i -> `String i))
    ~homePage:(apply (fun i -> `Bool i))
    ~permissions:(apply (fun i -> `Int i))
    ~contentStatus:(apply (fun i -> `String i))
    ~current:(apply (fun i -> `Bool i))
  |> fun ls -> `Assoc (List.rev ls)
