REPORTER = spec

test:
	    @./node_modules/mocha/bin/mocha \
	    --reporter $(REPORTER) \
	    test/*.coffee

.PHONY: test
