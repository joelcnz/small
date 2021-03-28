class Maths {
	int value;
	
	Maths plus(int a, int b) {
		value = a + b;
		
		return this;
	}
}

Maths minus(Maths maths, int a, int b) {
	maths.value = a - b;
	
	return maths;
}

void main() {
	auto maths = new Maths;
	
	import std.stdio;
	writeln(maths.plus(2, 1).value);
	writeln(maths.minus(10, 3).value);
	writeln(maths.value);
}