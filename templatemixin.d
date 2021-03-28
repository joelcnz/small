//#not got going

import std.stdio;

template mtest() {
	void mTest() {
		writeln("t");
	}
}

class Person {
	mixin mtest;
}

void main() {
	(new Person).mTest();
}

/+
//#not got going
template TypeTuple(T...) {
	alias T TypeTuple;
}

template staticMap(alias M, T...)
{
 static if (T.length == 0) // End of sequence	alias TypeTuple!() staticMap; // stop there
 else	 alias TypeTuple!(M!(T[0]), staticMap!(M, T[1..$])) staticMap;
}

void main() {
	assert( staticMap!((){}, [int, string]) == [2,4,6]);
}
+/
