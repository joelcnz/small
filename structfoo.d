struct Foo {
	int a;
	string str;
}

void main() {
	Foo[] foo = [{1, "hello"}, {2, "world"}];
	import std.stdio;
	writeln(foo);
}

