void main() {
	import std.algorithm.comparison : equal;
	import std.algorithm : map, filter, cache;
	import std.stdio, std.range;
	import std.typecons : tuple;

	ulong counter = 0;
	double fun(int x)
	{
	    ++counter;
	    // http://en.wikipedia.org/wiki/Quartic_function
	    return ( (x + 4.0) * (x + 1.0) * (x - 1.0) * (x - 3.0) ) / 14.0 + 0.5;
	}
	// Without cache, with array (greedy)
	auto result1 = iota(-4, 5).map!(a =>tuple(a, fun(a)))()
	                         .filter!(a => a[1] < 0)()
	                         .map!(a => a[0])()
	                         .array();

	// the values of x that have a negative y are:
	assert(equal(result1, [-3, -2, 2]));

	// Check how many times fun was evaluated.
	// As many times as the number of items in both source and result.
	writeln(counter); // iota(-4, 5).length + result1.length

	counter = 0;
	// Without array, with cache (lazy)
	auto result2 = iota(-4, 5).map!(a =>tuple(a, fun(a)))()
	                         .cache()
	                         .filter!(a => a[1] < 0)()
	                         .map!(a => a[0])();

	// the values of x that have a negative y are:
	assert(equal(result2, [-3, -2, 2]));

	// Check how many times fun was evaluated.
	// Only as many times as the number of items in source.
	writeln(counter); // iota(-4, 5).length
}