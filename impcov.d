import std.stdio;
import std.file;

void main() {
	// Iterate a directory in breadth
	string 
	foreach (string name; dirEntries(".", SpanMode.breadth)) {
		if (name.length > 2 && name.lastIndexOf(".") > -1)	
			writeln( "implib /s ", name[ 2 .. name.indexof(".") ] ~ "lib ", name.length > 1 ? name[ 2 .. $ ] : "?");
	}
}
