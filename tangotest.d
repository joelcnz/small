import tango.io.Stdout;
import tango.io.Console;
import std.stdio;
import std.string;
import std.conv;

pragma(lib, "libtango");

void main() {
	Stdout("Tango-D2").newline;
	writeln("Phobos-D2");
	foreach(count; 0..3 + 1)
		Stdout.formatln("Stdout.formatln: {}", count),
		writefln("writeln: %s", count);
	Stdout("Enter your Tango name: ")(); auto input1 = Cin.get(); /+ notice, no newline character +/ Stdout(input1).newline;
	write("Enter your Phobos2 name: "); auto input2 = stripRight(readln()); writeln(input2);
	
	Stdout.format("So you two are {}", input1).flush; writeln(" and ", input2);
	
	//Hmm..
//	Stdout(stdin.read);

	Cout("1/3: ")(); auto one = Cin.get(); Cout(one).newline; // the last cout on this line is printed on the next line, due to the Cin.Get() starts a new line
	Cout("2/3: ")(); auto two = cin; Cout(two).newline;
	Cout("3/3: ")(); string three; cin(three); Cout(three).newline;
}

string cin() @property {
	return to!string(Cin.get());
}

string cin(ref string got) @property {
	return got = to!string(Cin.get());
}
