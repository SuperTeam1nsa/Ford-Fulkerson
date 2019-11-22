(* Read a graph from a file,
 * Write a graph to a file. *)

open Graph

type path = string
type node = {id: int ; ptitnom: string}
(* Values are read as strings. *)
val from_file: path -> string graph

(* Similarly, we write only a string graph.
 * If necessary, use gmap (to be written by you) to prepare the input graph. *)
val write_file: path -> string graph -> unit

val export: path -> string graph -> Graph.id -> Graph.id -> unit

(* The format of files is compatible with the files generated by:
   https://www-m9.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html
*)
(*import affectations as string graph*)
val import: path -> Tools.labels graph * node list 

val export2: path -> Tools.labels graph -> node list -> int -> int -> unit

val export2_visible: path -> Tools.labels graph -> node list -> unit

val export2_text: path -> Tools.labels graph -> node list -> int -> int -> unit