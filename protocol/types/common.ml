open Core.Std
open Yojson

let get_val ~name ls json_to_val =
  try
    match Basic.Util.member name ls with
    | `Null -> None
    | v -> Some (json_to_val v)
  with _ ->
    None

module type Jsonable_internal = sig
  type t with sexp

  module Internal : sig
    val of_json : Basic.json -> t
  end

  val to_json : t -> Safe.json

  val of_json : Safe.json -> t
end

module type Jsonable = sig
  type t with sexp

  val to_json : t -> Safe.json

  val of_json : Safe.json -> t
end
