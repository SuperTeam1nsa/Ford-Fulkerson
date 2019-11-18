open Graph
(*
let gmap g f = 
let rec loop node_r f=
match node_r with
|empty_graph->empty_graph
|(n,arc)::r->(n,(e_fold arc (fun acc id1 id2 lab -> (f (id1 id2 lab))::acc) empty_graph))::(loop r f) 
in
loop g f *)
let clone_nodes g = n_fold g new_node empty_graph;;
let add_arcs g id1 id2 lab = 
  match find_arc g id1 id2 with
    |None -> new_arc g id1 id2 (lab)
    |Some x -> new_arc g id1 id2 (lab+x);;

(* peut etre directement remplacée par new_arc *)
let add_arcs_c g id1 id2 lab = 
  match find_arc g id1 id2 with
    |None -> raise Not_found
    |Some x -> new_arc g id1 id2 lab;;

(* la fonction new_arc ne crée pas de node, parmi ceux qui lui sont passés (tous via l'accu) elle ajoute des arcs=> on reconstruit le graphe comme ça => si noeud inexistant (ec: empty_graph => raise exception )*)
let gmap g f = e_fold g (fun gr id1 id2 lab-> new_arc gr id1 id2 (f lab)) (clone_nodes g);;
(*
let res= gmap empty_graph int_of_string;;
*)
type labels = 
    { max: int;
      current: int;
      visited: bool}

let label_of_string s=
  {max=(int_of_string s);
   current=0;visited=false}

let string_of_label l=
  string_of_int(l.current)^"/"^string_of_int(l.max)

(* add_arcs g accu_arcs *)
(* find arcs to use then add_arcs_labels min accu labels_arcs *)
(* List.reverse à la fin *)
(*n fold concatene 2 graphs sans les arcs=> add_arcs de n_fold *)

let not_visited_node gr id=
  try let out = (out_arcs gr id) in
    let rec loop reste =
      match reste with 
        |[] -> true
        |(id2,lab)::r-> if (lab.visited) then false else loop r in
      loop out
  with Not_found -> false;;
	   
let rec find_path gr id idfin accu =
  if id = idfin then accu else (
    try let out = (out_arcs gr id) in 
      let rec loop reste =
        match reste with 
          |[] -> []
          |(id2,lab)::r-> if (((lab.max - lab.current) > 0) && (not_visited_node gr id2))  then 
                let chemin= (find_path (add_arcs_c gr id id2 { lab with visited = true }) id2 idfin ((id,(id2,lab))::accu) ) in
                  match chemin with
                    |[]-> loop r
                    |_->chemin
              else loop r 
      in
        loop out
    with Not_found -> []);;

let rec max_flow res = function 
  | [] -> res
  | (id,(id2,lab)) :: lereste -> max_flow (min (lab.max - lab.current) res) lereste 

(*let res = find_path ((1,(2,(20,0)) :: (4,(10,0)) :: [] ) :: (2,(4,(20,0)) :: [] ) :: (2,(4,(20,0)) :: [] ) :: (4,(1,(20,0)) :: [] ) :: []) 1 4 [];;*)



let update_graphe lemax g path =
  let rec loop lemax gr path =
    match path with 
      |[] -> gr
      |(id1, (id2, lab))::r ->
          let new_lab = { lab with current = (lab.current + lemax); visited = false } in
            loop lemax (add_arcs_c gr id1 id2 new_lab ) r
  in
    loop lemax g path;;

let ford_fulkerson gr debut fin =
  let rec loop gr d f=
    let chemin = find_path gr d f [] in
      match chemin with
        |[]->gr
        |_->loop (update_graphe (max_flow 9999 chemin) gr chemin) d f
  in
    loop gr debut fin

