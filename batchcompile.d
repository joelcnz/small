module batchcompile;

void main(string[] sfiles) {
	import std.process;
	import std.stdio;

	sfiles = sfiles[1..$];
	if (sfiles[0] == "-run") {
		foreach(file; sfiles[1..$]) {
			writeln([file]);
			if (file != "batchcompile")
				("./" ~ file).spawnShell.wait; // windows ~ ".exe");
		}
		writeln("Done executing!");
	} else {
		foreach(file; sfiles) {
			("Compiling " ~ file).writeln;
			("dmd " ~ file).spawnShell.wait;
		}
		writeln("Done compiling!");
	}
}
