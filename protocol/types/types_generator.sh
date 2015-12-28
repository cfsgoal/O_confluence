#!/bin/bash

>&2 echo 'Enter space-separated array of fields'

read -a fields

>&2 echo 'Enter space-separated array of types'

read -a types

if [ "${#fields[@]}" -ne "${#types[@]}" ]
then
  >&2 echo 'Number of fields and types do not match'
  exit 1
fi

struct=""
creator=""
folder=""

for (( i = 0 ; i < ${#fields[@]} ; i++ ))
do
  if [ "${fields[i]}" == "type" ]
  then adjusted_field_name="type_"
  else adjusted_field_name="${fields[i]}"
  fi

  if [ "${types[i]}" == "list" ]
  then
    >&2 echo "Enter subtype for list at item $i"
    read subtype

    module="$(tr '[:lower:]' '[:upper:]' <<< ${subtype:0:1})${subtype:1}"
    creator="$creator\n    ~$adjusted_field_name:
      (get_val
         ~name:\"${fields[i]}\"
         obj
         (convert_each $module.Internal.of_json)
      )"

    folder="$folder\n    ~$adjusted_field_name:(apply (fun i ->
        List.map ~f:$module.to_json i
        |> fun l -> \`List l))"

    types[i]="$module.t list"
  else
    creator="$creator\n    ~$adjusted_field_name:
      (get_val ~name:\"${fields[i]}\" obj to_${types[i]})"

    type_cap="$(tr '[:lower:]' '[:upper:]' <<< ${types[i]:0:1})${types[i]:1}"    
    folder="$folder\n    ~$adjusted_field_name:(apply (fun i -> \`$type_cap i))"
  fi


  if [ "$i" -eq "0" ]
  then struct="  { $adjusted_field_name : ${types[i]} option"
  else struct="$struct\n  ; $adjusted_field_name : ${types[i]} option"
  fi

done


echo -e "\
open Core.Std
open Yojson

open Common

type t =
$struct
  } with fields,sexp

module Internal = struct
  let of_json obj =
    let open Basic.Util in
    Fields.create$creator
end

let of_json obj = Internal.of_json (Safe.to_basic obj)

let (to_json : t -> Safe.json) t =
  let apply to_json acc fld =
    match Field.get fld t with
    | Some val_ -> (Field.name fld, to_json val_)::acc
    | None -> acc
  in
  Fields.fold
    ~init:[]$folder
  |> fun ls -> \`Assoc (List.rev ls)\
"
