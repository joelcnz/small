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
 static if (T.length == 0) // End of sequence
 else
}

void main() {
	assert( staticMap!((){}, [int, string]) == [2,4,6]);
}
+/