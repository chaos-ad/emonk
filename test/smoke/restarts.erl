% This file is part of Emonk released under the MIT license. 
% See the LICENSE file for more information.

-module(restarts).

-export([run/0]).

run(0) ->
    ok;
run(N) ->
    {ok, Ctx} = emonk:start_vm(),
    emonk:eval(Ctx, <<"var f = function(x) {return x*3;};">>),
    {ok, 27} = emonk:call(Ctx, <<"f">>, [9]),
    run(N-1).

run() ->
    emonk:start(),
    io:format(".", []),
    code:add_path("ebin"),
    run(5),
    init:restart().

