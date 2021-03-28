// Fail
// Sort lines
import std.stdio;
import std.array;
import std.algorithm;

void main(string[] args)
{
    args[1..$]
		.map!(a => a.idup)
		.array
		.sort
		.copy(stdout.lockingTextWriter());
	writeln;
}
