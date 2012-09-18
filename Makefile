
TEST_SUPPORT = \
	test/etap.beam \
	test/test_util.beam

%.beam: %.erl
	erlc -o test/ $<

all:
	./rebar compile

check: all $(TEST_SUPPORT)
	prove test/*.t

clean:
	./rebar clean
	rm -f test/*.beam

start:
	exec erl -pa ebin deps/*/ebin -boot start_sasl -s emonk