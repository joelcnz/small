import std.stdio: writeln;
import std.string: split;
import std.conv: to;
import std.algorithm: reduce;

void main() {
	writeln( reduce!((a, b) => a + b)(0, "8 45 0".split.to!(int[])) );
//	writeln( reduce("8 45 0".split.to!(int[]), ) );
	
	writeln("fat cat|rotten pig".split("|"));
}
