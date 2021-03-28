import std.stdio;

void main() {
	writeln("int min: ", int.min );
	writeln("int max: ", int.max );
	
//	import std.algorithm.comparsion;
	import std.algorithm; //.comparison
	int a = 5;
	float b = 6;
	double c = 2;
	auto d = min(a, b);
	assert(is(typeof(d) == float));
	assert(d == 5);
	auto e = min(a, b, c);
	assert(is(typeof(e) == double));
	assert(e == 2);
}