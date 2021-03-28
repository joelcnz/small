//Last go: Jan 18 2012 //1st pop count: [X - 29.1.12]
//# "Finder" appears here
// use rangereducedotdotdotdelegatebug.d as a reference
@property bool empty(T)(T[] a) { return a.length == 0; }
@property ref T front(T)(T[] a) { return a[0]; }
void popFront(T)(ref T[] a) { a = a[1..$]; }

V reduce(alias fun, V, R)(V x, R range)
	if (is(typeof(x == x) == bool))
{
	for(; !range.empty; range.popFront())
		x = fun(x, range.front);
	return x;
}

double average(double[] values...) {
//	auto pred = (double a, double b) { return a+b; };
//	return reduce!(pred)(0.0, values) / values.length;
//	return reduce!"a + b"(0.0, values) / values.length;
	return reduce!((a, b) => a + b)(0f, values) / values.length;
}

T[] delegate(T[]) finder(T)(T x, string s)
	if (is(typeof(x == x) == bool))
{
	import std.algorithm, std.conv, std.stdio;
	return delegate(T[] a) { writeln(s); return find(a, x); };
}

void main() {
	assert(average(1,2,3) == 2);
	int[] delegate(int[]) d = finder(5, "Finder");
	import std.stdio;
	writeln("Before:");
	assert(d([4,5,6]) == [5,6]); //# "Finder" appears here
}
