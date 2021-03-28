import std.stdio;

struct A {
	int value;
	A add(int x, int y) {
		value = x + y;

		return this;
	}
}

A minus(A a, int x, int y) {
	a.value = x - y;
	return a;
}

void main() {
	A a;
	writeln(a.add(3, 4).value);
	writeln(a.minus(10, 3).value);
}
