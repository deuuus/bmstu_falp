domains
   name, gender = symbol.
   person = person(name, gender).
   generation = unsigned.
 
predicates
   parent(person, person).
   grand_parent(person, gender, person).
   n_parent(person, person, generation).
 
clauses
   grand_parent(person(GrandName, GrandGender), LineGender, person(ChildName, ChildGender)) :- 
   	parent(person(GrandName, GrandGender), person(ParentName, LineGender)), 
   	parent(person(ParentName, LineGender), person(ChildName, ChildGender)).
   	
   n_parent(person(ParentName, ParentGender), person(ChildName, ChildGender), 0) :- 
   	parent(person(ParentName, ParentGender), person(ChildName, ChildGender)).
   	
   n_parent(person(ParentName, ParentGender), person(ChildName, ChildGender), 1) :- 
   	grand_parent(person(ParentName, ParentGender), _, person(ChildName, ChildGender)).
   	
   n_parent(person(ParentName, ParentGender), person(ChildName, ChildGender), N) :- N>1, M=N-2,
   	n_parent(person(ParentName, ParentGender), person(TmpName, TmpGender), M),
   	grand_parent(person(TmpName, TmpGender), _, person(ChildName, ChildGender)).
 
   % 2 children and their parents
   parent(person("F_Parent^0", f), person("Female", f)).
   parent(person("M_Parent^0", m), person("Female", f)).
   
   parent(person("F_Parent^0", f), person("Male", m)).
   parent(person("M_Parent^0", m), person("Male", m)).
   
   % Grandparents.
   parent(person("FF_Parent^1", f), person("F_Parent^0", f)).
   parent(person("MF_Parent^1", m), person("F_Parent^0", f)).
   
   parent(person("FM_Parent^1", f), person("M_Parent^0", m)).
   parent(person("MM_Parent^1", m), person("M_Parent^0", m)).
   
   % Great-grandparents.
   parent(person("FFF_Parent^2", f), person("FF_Parent^1", f)).
   parent(person("MFF_Parent^2", m), person("FF_Parent^1", f)).
   
   parent(person("FMF_Parent^2", f), person("MF_Parent^1", m)).
   parent(person("MMF_Parent^2", m), person("MF_Parent^1", m)).
   
   parent(person("FFM_Parent^2", f), person("FM_Parent^1", f)).
   parent(person("MFM_Parent^2", m), person("FM_Parent^1", f)).
   
   parent(person("FMM_Parent^2", f), person("MM_Parent^1", m)).
   parent(person("MMM_Parent^2", m), person("MM_Parent^1", m)).
 
 goal
   n_parent(person(Name, m), person("F_Parent^0", f), 1).