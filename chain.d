// Works! see vikda.d

void main() {
	import std.stdio : writeln;
	import std.algorithm : map;
	import std.range : chain;

	struct Foo {}

	auto f = Foo();
	auto foos = [f];
	auto foo = foos.map!(x => "foo")();
	auto bar = foo.chain(["bar"]);
	writeln(bar);
}
