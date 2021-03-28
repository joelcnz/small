import std.stdio;
import std.algorithm;
import std.array;

void main() {
  auto a = [ 1, 2, 3, 4, 5 ];
  writeln(a.canFind(4) ? "Yes" : "No");
  writeln(a.canFind(-5) ? "Yes" : "No");
}

version(Crazy) { // return write("no"); // still works though
import std.conv;
import std.stdio;
import std.string;

void main() {
	
	int n = readln.strip.to!int;
	string s = readln.strip;
	
	foreach (from; 0 .. n)
	foreach (jump; 1 .. n) {
		bool ok;
		foreach (i; 0 .. 5) {
			int pos = from + i * jump;
			if (pos >= n || s[pos] != '*') {
				ok = true;
				break;
			}
		}
		if (!ok)
			return write("yes");
	}
	
	return write("no");
}
} // version crazy
