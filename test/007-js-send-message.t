#!/usr/bin/env escript
%%! -smp +K true -pa ./test/ -pa ./ebin/
% This file is part of Emonk released under the MIT license. 
% See the LICENSE file for more information.

main(_) ->
    emonk:start(),
    test_util:run(unknown, fun() -> test() end),
    emonk:stop().

test() ->
    {ok, Ctx} = emonk:start_vm([{callback, fun(X) -> X*2 end}]),
    test_send_exists(Ctx),
    test_send_message(Ctx),
    ok.

test_send_exists(Ctx) ->
    JS = <<"var f = (erlang.call !== undefined); f;">>,
    etap:is(emonk:eval(Ctx, JS), {ok, true}, "erlang.call function exists.").

test_send_message(Ctx) ->
    JS = <<"var f = erlang.call(1.3).result == 2.6; f;">>,
    etap:is(emonk:eval(Ctx, JS), {ok, true}, "message passed ok").
