module app;

import std.stdio: writeln;
import std.array: popFront;
import std.string: join;
import std.algorithm: each;
import std.conv: to;

void main(string[] args) {
	args.popFront();

	int total;
	void add(string n) { total += n.to!int; }
	args.each!add;
	writeln(total);
}
