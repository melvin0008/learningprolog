go :- hypothesize(SoccerTeam),
      write('I guess that the SoccerTeam is: '),
      write(SoccerTeam),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(liverpool)   :- liverpool, !.
hypothesize(arsenal)     :- arsenal, !.
hypothesize(madrid)   :- madrid, !.
hypothesize(barcelona)     :- barcelona, !.
hypothesize(acmilan)   :- acmilan, !.
hypothesize(intermilan)   :- intermilan, !.
hypothesize(napoli) :- napoli, !.
hypothesize(unknown).             /* no diagnosis */

/* team identification rules */
liverpool :- english, 
           verify(are_REDS),
           verify(at_anfield).
arsenal :- english,  
         verify(are_the_unbeaten_49), 
         verify(at_emirates).
madrid :- spanish, 
           verify(is_capital), 
           verify(has_won_cl_the_most).
barcelona :- spanish,  
         verify(has_messi).

acmilan :- italian,  
           verify(had_maldini), 
           verify(is_capital).
intermilan :- italian,  
           verify(has_won_cl_in_2009),
           verify(is_the_rival_of_acmilan).
napoli :- italian,
             verify(managed_by_rafa),
             verify(had__maradona).

/* classification rules */
english    :- verify(is_english), !.
english    :- verify(are_physical).
italian      :- verify(is_italian), !.
italian      :- verify(is_all_about_pace), !. 
spanish :-   verify(are_the_most_skillful), !.
spanish :-   verify(is_spanish).

/* how to ask questions */
ask(Question) :-
    write('Does the SoccerTeam have the following attribute: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.