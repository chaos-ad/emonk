My fork of emonk library, in which I fix stuff for my own good.  
Original can be found here: http://github.com/davisp/emonk/

emonk - Accidentally Refactored erlang_js
=========================================

[erlang_js][erlang_js] is awesome. But I started refactoring. Now there's emonk.

With the latest versions of Emonk there's quite a bit of difference now. Emonk
is NIF based and uses a thread-pool to move JavaScript execution off of the
Erlang scheduler threads. Translation from Erlang terms to JavaScript objects
uses a native translation step to avoid JSON overhead. I haven't gotten around
to actually testing to see if there's any sort of appreciable difference in
speed.

[erlang_js]: http://hg.basho.com/erlang_js/

Requisites
----------

1. A fairly recent version of Spidermonkey. I use the version from HomeBrew
   which uses [this url][spidermonkey].
2. R14A. Emonk uses the new NIF API extensively.

[spidermonkey]: http://hg.mozilla.org/tracemonkey/archive/57a6ad20eae9.tar.gz

Building
--------

Hopefully the build scenario is something like:

    $ git clone git://github.com/davisp/emonk.git
    $ cd emonk
    $ make
    $ make test

Running
-------

I've been using [etap][etap] to test as I code. Its awesome. You should use it.
That said, running is pretty cake assuming emonk is on your Erlang code path:

    $ ERL_LIBS=~/awesome_projects/emonk/src erl -s emonk
    {ok, Context} = emonk:start_vm().
    {ok, 6} = emonk:eval(Context, <<"var f = 2; f*3;">>).
    {ok, undefined} = emonk:eval(Context, <<"var g = function(x) {return x*4;};">>).
    {ok, 36} = emonk:call(Context, <<"g">>, [9]).

[etap]: http://github.com/ngerakines/etap

Bugs and Things
---------------

The best place to file [bugs][bugs] is at the [issue][bugs] tracker on
[GitHub][github]. Less yapping, more tapping. Thanks [mattly][mattly].

[bugs]: http://github.com/davisp/emonk/issues
[github]: http://github.com/davisp
[mattly]: http://twitter.com/mattly

Yep
---

That's pretty much it. Mostly this was internal churn that I kinda started
chasing around like my tail. Hopefully things are easy enough to follow in the
logs and code.
