(** module Tools *) 
open Graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val clone_nodes: 'a graph -> 'b graph
val add_arcs: int graph -> id -> id -> int -> int graph
type labels = { max : int; current : int; }

val label_of_string : string -> labels
val string_of_label : labels -> string

val min_flow : int -> ('a * ('b * labels)) list -> int
val update_graphe :
  int ->
  labels Graph.graph ->
  (Graph.id * (Graph.id * labels)) list -> labels Graph.graph
val find_path :
    labels Graph.graph ->
    Graph.id -> Graph.id ->
    (Graph.id * (Graph.id * labels)) list -> (Graph.id * (Graph.id * labels)) list
  
 (* 
val find_path :
  labels Graph.graph ->
  Graph.id ->
  Graph.id ->
  (Graph.id * (Graph.id * labels) list) list ->
  (Graph.id * (Graph.id * labels) list) list
  *)