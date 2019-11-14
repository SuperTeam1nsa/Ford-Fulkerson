open Graph 

(*
let gmap g f = 
let rec loop node_r f=
match node_r with
|empty_graph->empty_graph
|(n,arc)::r->(n,(e_fold arc (fun acc id1 id2 lab -> (f (id1 id2 lab))::acc) empty_graph))::(loop r f) 
in
loop g f *)

(* la fonction new_arc ne crée pas de node, parmi ceux qui lui sont passés (tous via l'accu) elle ajoute des arcs=> on reconstruit le graphe comme ça => si noeud inexistant (ec: empty_graph => raise exception )*)
let gmap g f = e_fold g (fun gr id1 id2 lab-> new_arc gr id1 id2 (f lab)) (clone_nodes g);;
(*
let res= gmap empty_graph int_of_string;;
*)
type labels =
    { max: int;
      current: int }
let label_of_string s=
  {max=(int_of_string s);current=0}
let string_of_label l=
  string_of_int(l.current)


(* find arcs to use then add_arcs_labels min accu labels_arcs *)
(* List.reverse à la fin *)
let rec find_path gr id idfin accu =
  if id = idfin then accu else (
    try let out = (out_arcs gr id) in 
      let rec loop reste =
        match reste with 
          |[]->[]
          |(id2,(m,c))::r-> if ((m - c) >0) then find_path gr id2 idfin ((id,(id2,(m,c)) :: [])::accu) else loop r   (* sinon mettre 2 ids si matter , :: [] pour garder def graph *)
      in
        loop out
    with Not_found ->[]);;
let res = find_path ((1,(2,(20,0)) :: (4,(10,0)) :: [] ) :: (3,(4,(20,0)) :: [] ) :: (2,(4,(20,0)) :: [] ) :: (4,(1,(20,0)) :: [] ) :: []) 1 4 empty_graph;
