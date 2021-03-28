//#failed to launch on Mac
/+
Eg.
./liner import std.stdio; void main() { writeln(#Hey!#); } // had it working in MacOS, should work still
liner import std.stdio, std.string, std.conv; void main() { int total = 0; foreach(n; `1 2 3 4`.split().to!(int[])) total += n; writeln(`Total: `, total); } // windows
 
Note: the '#' are converted to '"' before being compiled.
Programmer note: maybe just use '`' instead of '#'
 +/
import std.stdio, std.file, std.process, std.string, std.array;

void main(string[] args) {
	if (args.length == 1) {
		writeln("Code needed.");
		return;
	}
	
	auto line = args[1 .. $].join(" ");

	line = replace(line, "#", `"`);

	string exe = "line";

	version(Windows)
		exe ~= ".exe";
	version(OSX)
		exe = "./"~exe;

	if (exists(exe))
		std.file.remove(exe);

	File("source.d", "w").write(line);
	//system("dmd -ofline source"); // not work on Mac
	system(["dmd","-ofline","-run","source.d"]);
}
