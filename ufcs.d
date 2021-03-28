import std.stdio;

class A {
	int a, b;
	int value;
	A add(int a, int b) {
		value = a + b;
		return this;
	}
}

A minus(A a, int x, int y) {
	a.value = x - y;
	return a;
}

void main() {
	A a = new A;
	writeln(a.add(3, 4).value);
	writeln(a.minus(10, 3).value);
}
