///Jesse Philips
import std.stdio: writeln;
import std.algorithm : map;
import std.conv : to;

import std;

void main(string[] args) {
//	if (args.length == 1)
//		args ~= "37";
//	int num = args[1].to!int
	int squareDel(int a) { return a*a; }
	int cubeDel(int a) { return a*a*a; }

	auto vs = [2, 3];
	auto delarr = [&squareDel, &cubeDel];
	auto arr = iota(1, 10);

	foreach(i, del; delarr) {
		write(vs[i], " - "); writeln(arr.map!(del));
	}

}

