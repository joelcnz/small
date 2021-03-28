// readf Not work! - using readln
import std.stdio;
//import std.string: strip;
import std.ascii;
import std.algorithm;

auto strToUpper(string str, int[] pos...) {
	auto str2 = str.dup;
	foreach(p; pos)
		str2[p] = toUpper(str2[p]);
	return str2.idup;
}

void main() {
//http://forum.dlang.org/thread/k4fm8e$1mf4$1@digitalmars.com?page=2
	int[] arr = [1,2]; //,3,4,5];
	auto r = arr.reduce!((a,b) => a + b, (a,b) => a + b * b);
	writefln("sum = %s, sum of squares = %s", r[0], r[1]);

	writeln(strToUpper("house", 0, 1, 4));
	writeln(strToUpper("a rock", 2));
	
	writeln("Enter two numbers:");
	int x, y;
	try {
		readf("%d %d", &x , &y);
	} catch(Exception e) {
		writeln("Oops! wrong input..");
		return;
	}
	writeln(x, "+", y, "=", x + y);
}
