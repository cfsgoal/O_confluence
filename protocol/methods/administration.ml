open Core.Std
open Async.Std
open Yojson
open Cohttp_async

let export_site ~uri token export_attachments =
  Shared.request
    ~uri
    ~method_name:"exportSite"
    [ `String token
    ; `Bool export_attachments
    ]
  >>=? function
  | `String url ->
    Uri.of_string url
    |> Deferred.Or_error.return
  | obj -> Shared.unrecognized obj

let get_cluster_information ~uri token =
  Shared.request
    ~uri
    ~method_name:"getClusterInformation"
    [ `String token ]
  >>|? fun info ->
  Clusterinformation.of_json info
