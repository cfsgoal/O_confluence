open Core.Std
open Async.Std

type t = string

module Creds = struct
  module V1 = struct
    type t =
      { username : string
      ; password : string
      }

    let create ~username ~password =
      { username; password}
  end

  type t =
    [ `V1 of V1.t ]

  let create_v1 ~username ~password =
    `V1 (V1.create ~username ~password)
end

let login ~uri creds =
  begin match creds with
  | `V1 creds ->
    Shared.request
      ~uri
      ~method_name:"login"
      [ `String creds.Creds.V1.username
      ; `String creds.Creds.V1.password
      ]
  end
  >>=? function
  | `String t -> Deferred.Or_error.return t
  | obj -> Shared.unrecognized obj

let logout ~uri t =
  Shared.request
    ~uri
    ~method_name:"logout"
    [ `String t ]
  >>=? function
  | `Bool b -> Deferred.Or_error.return b
  | obj -> Shared.unrecognized obj
