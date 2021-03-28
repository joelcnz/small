import std.stdio;
import std.algorithm;
import std.string;

void main() {
// Error: no overload matches for remove
// char[] cs = "1023".dup; writeln(cs.remove(1)); // remove does not work 

	ubyte[] bs = [1, 0, 2, 3];
	writeln(bs.remove(1));

	dchar[] dcs = "1023"d.dup;
	writeln(dcs.remove(dcs.indexOf('0')));
}
