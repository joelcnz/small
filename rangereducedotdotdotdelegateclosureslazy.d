import std.algorithm, std.array, std.stdio;

// Range functions
@property bool empty(T)(T[] a) { return a.length == 0; } //is the range empty?
@property ref T front(T)(T[] a) { return a[0]; } // get at first element
void popFront(T)(ref T[] a) { a = a[1 .. $]; } // shed first element

// uses a function literal
V reduce(alias fun, V, R)(V x, R range)
	if (is(typeof(x = fun(x, range.front)))
		&& is(typeof(range.empty) == bool)
		&& is(typeof(range.popFront())))
{
    for ( ; !range.empty; range.popFront()) {
        x = fun(x, range.front);
    }
    return x;
}

version(none) {
	// or resrictions as:
	import std.range;
	V reduce(alias fun, V, R)(V x, R range)
		if (isInputRange!R && is(typeof(x = fun(x, range.front)))) {
		for ( ; !range.empty; range.popFront()) {
			x = fun(x, range.front);
		}
		return x;
	}
}

// compute the avg of a set of numbers, passable directly or via an array
double average(double[] values...)
{
    if (values.empty)
    {
        throw new Exception("Average of zero elements is undefined");
    }
    return reduce!((a, b) => a + b)(0.0, values) / values.length;
}

//closure 1/2
T[] delegate(T[]) finder(T)(T x, string s)
	if (is(typeof(x == x) == bool))
{
	import std.algorithm, std.stdio;
	return delegate(T[] a) { writeln(s); return find(a, x); };
}

// normal type template(?) function
string add(T1, T2)(string s, T1 x, T2 y) {
	import std.conv; return text(s, x+y); 
}

//lazy evaluation (can be done with delegates)
void doTimes(int count, lazy void exp) {
	foreach(cmp; 0 .. count)
		exp();
}

bool scase(bool b, lazy void dg) {
	if (b)
		dg();
	return b;
}
/* Here the variadic arguments are converted to delegates in this special case. */
void cond(bool delegate()[] cases ...) {
	foreach (c; cases) {
		if (c())
			break;
	}
}

void lazyFoo(int v) {
	cond (
		scase(v == 1, writefln("it is 1")),
		scase(v == 2, writefln("it is 2")),
		scase(v == 3, writefln("it is 3")),
		scase(true, writefln("it is the default"))
	);
}

//delegate
void doTimes(lazy void start, int count, void delegate() exp, lazy void end) {
	start();
	foreach(c; 0..count)
		exp();
	end();
}

//closure 2/2
string delegate(string) add(T1, T2)(T1 x, T2 y) {
	return delegate(string s) { import std.conv; return text(s, x+y); };
}

void doAdding() {
	string delegate(string) dAdd = add(1,2);
	writeln(dAdd("One + two = "));
	writeln(dAdd("1 + 2 = "));
	
	writeln(add("One + two = ", 1, 2));
	writeln(add("1 + 2 = ", 1, 2));

	auto dAdd2 = add(3,4);
	writeln(dAdd2("Three + four = "));
	writeln(dAdd2("3 + 4 = "));

	writeln(add("Three + four = ", 3, 4));
	writeln(add("3 + 4 = ", 3, 4));
}

// entry point
void main() {
	assert(average(1, 2) == 1.5);
	assert(average(1, 2, 3) == 2);

	// passing arrays and slices works too
	double[] v = [1, 2, 3];
	assert(average(v) == 2);
	
	int[] delegate(int[]) dFinder = finder(5, "Clay");
	import std.stdio;
	writeln("Before:");
	assert(dFinder([1,2,3,4,5,6,7,8,9]) == [5,6,7,8,9]);

	doAdding();

	//Lazy
	int x = 0;
	write("lazy evaluation: ");
	doTimes(10, write(x++));
	writeln();
	lazyFoo(2);
	lazyFoo(200);
	
	//delegate
	x = 0;
	doTimes(write("Start-"), 10, { write(x++); write("-"); }, writeln("end"));
	writeln();
}
