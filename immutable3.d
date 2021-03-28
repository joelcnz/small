immutable int z;
void test()
{
//    z = 3; // error, z is immutable
}
static this()
{
    z = 3; // ok, can set immutable that doesn't
           // have static initializer
}

void main() {
	import std.stdio;
	writeln("z = ", z);

	int foo(int f) { return f * 3; }
	int i = 5;
	immutable x = 3 * 4;      // ok, 12
	//immutable y = i + 1;      // error, cannot evaluate at compile time
	immutable z = foo(2) + 1; // ok, foo(2) can be evaluated at compile time, 7
}
