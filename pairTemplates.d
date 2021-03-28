module pair;

import std.stdio;

void main()
{
	writeln("hello joel");

	auto array = pair!(string)("item"); // no need to do pair!(int).pair(1)
	
	writeln(array);
}

template pair(T) {
    // template 'pair' declares only a 'pair' member
	T[] pair(T t) { return [t,t];}
}
