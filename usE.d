// Not work! dmd 1.040 - works dmd 2.029
// Off digitalmars.D.learn - unknowen/John C
import std.stdio;
import std.array;
import std.conv;
import std.format;
import std.string;

void main() {
	string str = "1 2 3 4 5 6";
	double[] numbers = std.conv.to!(double[])(split(str));
	writefln(std.conv.to!string(numbers));
	
	auto writer = appender!string();
	formattedWrite(writer, "(%(%s. %))", numbers);
	writeln(writer.data);

	// Org from D offline help
	writer = appender!string();
    formattedWrite(writer, "\n%s is the ultimate %s.", 42, "answer");
    assert(writer.data[1 .. $] == "42 is the ultimate answer.");
    writeln(writer.data);
    // Clear the writer
    writer = appender!string();
    formattedWrite(writer, "Date: %2$s %1$s", "October", 5);
    assert(writer.data == "Date: 5 October");
    writeln(writer.data);
    writeln(typeid(typeof(writer.data)), '\n');

	writeln(split("1.0 2.0 3.0 4.0 5.0 6.0 7.0"),
		"\nvoid main() {\n"
		"  double[] dbs= [", ", ", "];\n}\n");
	
	foreach(s;split("I went for a walk and fell down a hole!")) {
		writefln(s);
	}
}
