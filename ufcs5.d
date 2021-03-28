//alias jtype = short; // not so good
alias jtype = long;

class Maths(T) {
	T value;
	
	auto plus(T1, T2)(T1 a, T2 b) pure {
		value = a + b;
		
		return this;
	}
}

auto minus(T1, T2)(Maths!jtype maths, T1 a, T2 b) pure {
	maths.value = a - b;
	
	return maths;
}

void main() {
	auto maths = new Maths!jtype;
	
	import std.stdio;
	writeln(maths.plus(1L, 2).value);
	writeln(maths.minus!jtype(10, 3).value);
	writeln(maths.value);
}
