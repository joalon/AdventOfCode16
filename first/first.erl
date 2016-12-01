-module(first).

-export([solve/2, run/1, parse/2, doMove/2]).

run(Filename) ->
	{ok, Data} = file:read_file(Filename),
	SplitData = binary:split(Data , <<", ">> , [global]),
	ParsedData = parse(SplitData, []),
	%print(ParsedData).
	solve({north,0,0}, ParsedData).

parse([], Acc) ->
	lists:reverse(Acc);
parse([<<"R", Rest/binary>>|AllTheRest], Acc) ->
	parse(AllTheRest, [{right, list_to_integer(binary_to_list(Rest))}|Acc]);
parse([<<"L", Rest/binary>>|AllTheRest], Acc) ->
	parse(AllTheRest, [{left, list_to_integer(binary_to_list(Rest))}|Acc]).

solve(CurrentPosition, []) ->
	{ok, CurrentPosition};
solve(CurrentPosition, [NextMove|ListOfMoves]) ->
	solve(doMove(CurrentPosition, NextMove), ListOfMoves).

doMove({north, CurrentX, CurrentY}, {right, Length}) ->
	{east, CurrentX + Length, CurrentY};
doMove({north, CurrentX, CurrentY}, {left, Length}) ->
	{west, CurrentX - Length, CurrentY};

doMove({east, CurrentX, CurrentY}, {right, Length}) ->
	{south, CurrentX, CurrentY - Length};
doMove({east, CurrentX, CurrentY}, {left, Length}) ->
	{north, CurrentX, CurrentY + Length};
	
doMove({south, CurrentX, CurrentY}, {right, Length}) ->
	{west,  CurrentX - Length, CurrentY};
doMove({south, CurrentX, CurrentY}, {left, Length}) ->
	{east, CurrentX + Length, CurrentY};
	
doMove({west, CurrentX, CurrentY}, {right, Length}) ->
	{north, CurrentX, CurrentY + Length};
doMove({west, CurrentX, CurrentY}, {left, Length}) ->
	{south, CurrentX, CurrentY - Length}.