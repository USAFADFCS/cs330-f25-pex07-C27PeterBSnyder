% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Brody Snyder
%
% Documentation: Used the following online tutorial to better understand and utilize
%                the difference between the and and or operations in prolog (, vs ;).
%                https://stackoverflow.com/questions/20104042/prolog-and-or-expressions-boolean-function
%                Only other resource used was the provided example code in HW07.

% The query to get the answer(s) or that there is no answer
% ?- solve.

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

day(tue).
day(wed).
day(thu).
day(fri).

object(weather_balloon).
object(kite).
object(fighter).
object(cloud).

solve :- 
    day(SmithDay), day(GarciaDay), day(ChenDay), day(JonesDay),
    all_different([SmithDay, GarciaDay, ChenDay, JonesDay]),
    
    object(SmithObject), object(GarciaObject), object(ChenObject), object(JonesObject),
    all_different([SmithObject, GarciaObject, ChenObject, JonesObject]),
    
    Triples = [ [smith, SmithDay, SmithObject],
                [garcia, GarciaDay, GarciaObject],
                [chen, ChenDay, ChenObject],
                [jones, JonesDay, JonesObject] ],
                
    % 1. C4C Smith did not see a weather balloon, nor kite.
	\+ member([smith, _, weather_balloon], Triples),
    \+ member([smith, _, kite], Triples),
                
	% 2. The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia, _, kite], Triples),

    % 3. Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    (member([chen, fri, _], Triples);
     member([_, fri, fighter], Triples)),

	% 4. The kite was not sighted on Tuesday.
	\+ member([_, tue, kite], Triples),
    
	% 5. Neither C4C Garcia nor C4C Jones saw the weather balloon.
	\+ member([garcia, _, weather_balloon], Triples),
    \+ member([jones, _, weather_balloon], Triples) ,
    
	% 6. C4C Jones did not make their sighting on Tuesday.
	\+ member([jones, tue, _], Triples),
    
	% 7. C4C Smith saw an object that turned out to be a cloud.
	member([smith, _, cloud], Triples),
        
	% 8. The fighter aircraft was spotted on Friday.
	member([_, fri, fighter], Triples),
    
	% 9. The weather balloon was not spotted on Wednesday.
    \+ member([_, wed, weather_balloon], Triples),
    
    tell(smith, SmithDay, SmithObject),
    tell(garcia, GarciaDay, GarciaObject),
    tell(chen, ChenDay, ChenObject),
    tell(jones, JonesDay, JonesObject).
    
% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).
    
tell(X, Y, Z) :-
    write('C4C '), write(X), write(' sighted on '), write(Y),
    write(' a '), write(Z), write('.'), nl.
