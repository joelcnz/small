/**
 * Uses the DMD compiler, but allows you to use a wildcard
 * 
 * Compile: dmd dmj
 * ---
 * dmj -c -D *.d
 * ---
 */
module dmj;

//pragma(lib, "wildcard"); // linker fails

import wildcard.wildcard;

import std.stdio;
import std.string;
import std.file;
import std.process;
import std.path;
import std.ascii: toUpper;

alias std.string.join join;

void main(string[] args) {
	debug
		writeln("args: ", args.join(" "));
	string line;
	line ~= "dmd";
	auto shallow = true;
	DirIterator dirs;
	foreach(arg; args[1 .. $]) {
		if (arg == "+depth") {
			shallow = false;
			continue;
		}
		/+
		.\cat.d
		.\dog.d
		temp\mouse.d
		temp\rat.d
		
		dmj *.d temp\*.d			
		+/
		bool used = false;
		debug
			writeln("arg: ", arg);

		if (arg.lastIndexOf(`.d`) != -1)
			// maybe need to be clearer
			foreach(string name; dirEntries(arg[0 .. (arg.lastIndexOf(`\`) == -1 ? 0 : arg.lastIndexOf(`\`))],
											shallow ? SpanMode.shallow : SpanMode.depth)) {
				debug
					writeln("name: ", name);
				if (wildMatch(arg, name)) {
					line ~= ' ' ~ name;
					used = true;
				}
			}
		if (! used)
			line ~= ' ' ~ arg;
	}
	writeln(line);
	
	auto pid = spawnShell(line);
	wait(pid);
//	system(line);
	/+
	write("Continue [Y]es? ");
	stdout.flush;
	if (readln[0].toUpper == 'Y')
		system(line);
	else
		write("Operation canceled! ");
	+/
}
