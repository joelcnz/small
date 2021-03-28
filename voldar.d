//#not work
import std.stdio;

void main() {
    writeln(max(23, 22.2));
	//writeln(x2(max(23, 22.2))); //#not work
	pragma(msg, "Testing 1.2.3");
}

auto max(U,V)(U u, V v) {
    return u < v ? v : u;
}

int x2(int x) { return x * 2; }
