// This would be good to get it going!
/*
example:
input:
dmd jtest.d libcalc.d
jtest "3 * 7 + 9 + 1"

output:
3 * 7 + 9 + 1 = 31
*/
module strcalc;

import std.stdio;
import std.string;// : whitespace, removechars, strip;
import std.ascii;
//import libcalcbase.libcalc;
import libcalc;

void main(string[] args) {
version (none) {
	string exp = "1 + 2 * 3";
	if (args.length > 1)
		exp = args[1];
}
	string exp;
	writeln("Write an equation (eg. 1 + 2):");
	exp = readln.chomp;
	auto result = exp.removechars(whitespace).calc;
	writeln(exp, " = ", result);
}