import std.stdio;

void main() {}

ref int bump(ref int x) {
	return ++x;
}

unittest {
	int x=0;
	
	writeln( bump(bump(x)) );
	assert(x is 2);
	
	writeln(x.bump.bump);
	assert(x is 4);
}