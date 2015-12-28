open Core.Std
open Async.Std
open Cohttp_async
open Yojson

let request ~uri ~method_name params =
  let id = Random.bits () in
  let json_body =
    `Assoc
      [ "jsonrpc", `String "2.0"
      ; "method", `String method_name
      ; "params", `List params
      ; "id", `Int id
      ]
  in
  let body = Body.of_string (sprintf !"%{Safe}" json_body) in
  Client.post ~body uri
  >>= fun (resp, body) ->
  let status = Response.status resp in
  let int_status = Cohttp.Code.code_of_status status in
  match Cohttp.Code.is_success int_status with
  | false ->
    let string_status = Cohttp.Code.string_of_status status in
    Or_error.errorf "HTTP request failed with code %i: %s"
      int_status string_status
    |> return
  | true ->
    Body.to_string body
    >>| fun str ->
    Ok (Safe.from_string str)

let unrecognized json =
  Or_error.errorf
    !"Unrecognized return: %{Yojson.Safe}" json
  |> return
