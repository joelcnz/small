struct Foo(T) {	}

auto bar(string s, ref Foo!int i) { return 0; }

void main()
{
	import std.stdio;
    writeln(typeof(&bar).stringof);
}
