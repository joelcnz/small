// 22 Feb 2012
// Ref: binarytree2.d
import tango.io.Console;
import std.conv;

pragma(lib, "libtango");

void main() {
	Cout("1/3: ")(); auto one = Cin.get(); Cout(one).newline; // the last cout on this line is printed on the next line
	Cout("2/3: ")(); auto two = cin; Cout(two).newline;
	Cout("3/3: ")(); string three; cin(three); Cout(three).newline;
}

string cin() @property {
	return to!string(Cin.get());
}

string cin(ref string got) @property {
	return got = to!string(Cin.get());
}
