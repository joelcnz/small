	// Org from bearophile ng d.D - 3 Mar 2011 2:58pm
import std.stdio;

struct Foo {
    int x;

    auto opBinary(string op:"*")(Foo other) {
        Foo result = Foo(x * other.x);
        return result;
    }

    auto opAssign(Foo other) {
		//assert(other.x >= 0);
		writeln("In here!");
        x = other.x;
		return x;
   }
}

void main() {
    Foo a, b, c;
	a = Foo(3),
	b = Foo(-2),
	c = a;
	auto d = (string state) { writefln("%s: a=%s, b=%s, c=%s", state, a.x, b.x, c.x); };
	d( "Before" );
	a = a * Foo(3);
	d( "After" );
}
