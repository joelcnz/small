void main() {
	// list source files
	static import std.stdio;
	import std.file;
	import std.algorithm, std.array, std.string;
	
	int count;
	foreach(string name; filter!`endsWith(a.name, ".d")`(dirEntries(".", SpanMode.shallow)).array.sort!"a.toLower < b.toLower") {
		std.stdio.write(name[2 .. $], " ");
		count += 1;
	}
	std.stdio.writeln("\nFiles count: ", count);
}

