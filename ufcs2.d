class Maths {
	int value;
	
	Maths plus(int a, int b) {
		value = a + b;

		return this;
	}
}

Maths minus(Maths s, int a, int b) {
	s.value = a - b;
	
	return s;
}

string toString(Maths m, int a, int b) {
	import std.string;
	writeln("%s and %s", a, b);
	
	return m;
}

void main() {
	auto a = new Maths;
	import std.stdio;

	writeln("Plus ", a.toString, a.plus(3, 14).value);
	writeln("Minus ", a.toString, a.minus(10, 3).value);
	writeln("Value: ", a.value);
}