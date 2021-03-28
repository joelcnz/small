import std.stdio;

struct S {
	int a, b;
}

S add(inout(int) a, int b) {
	return S(a, b);
}

void main() {
	S a;
	writeln(add(1, 2).a, ' ', add(1, 2).b, ' ', add(1, 2).a + add(1, 2).b);
}