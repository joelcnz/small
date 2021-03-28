import std.stdio;
import std.file;

void main(string[] args) {
	int i = 1;
	foreach(char[] line; File(args[1], "r").byLine())
		writefln("%03d %s", i++, line);
}
