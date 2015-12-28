open Core.Std
open Async.Std

type t = string

module Creds : sig
  type t

  val create_v1 : username:string -> password:string -> t
end

val login : uri:Uri.t -> Creds.t -> t Or_error.t Deferred.t

val logout : uri:Uri.t -> t -> bool Or_error.t Deferred.t
