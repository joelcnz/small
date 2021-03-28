//#but auto Int = nameOf!(int); does not
module nameof1;

import std.stdio;

template nameOf(alias name) {
	enum string nameOf = name.stringof;
}

struct Example { int i; }

void main() {
	Example example;
	int a;

	auto str = nameOf!(Example); //#but 'auto Int = nameOf!(int);' does not
	auto str2 = nameOf!(example);
	auto Int = nameOf!(a);
	
	assert(str == "Example");
	assert(str2 == "example");
	assert(Int == "a");
}
