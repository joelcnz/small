// eg ./search . .d
import std.stdio: writeln, writefln;
import std.file: dirEntries, SpanMode, DirEntry;
//import std.string: find, rfind;
import std.algorithm;
import std.string;

void main(string[] args) {
	writeln("Args:", args);
	// Iterate a directory and get detailed info about it
	foreach (DirEntry e; dirEntries(".", SpanMode.shallow)) {
		if (e.name.endsWith(args[1]))
			writefln("%20s bytes: %s", e.name[2 .. $], e.size);
	}
}
