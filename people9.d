import std.stdio;
import std.string;
import std.range;
import std.conv;
import std.algorithm;

struct Person {
	string name;
	int age;
	
	string toString() const {
		return format("%10s : %s", name, age);
	}
}

void main() {
	Person[] ppl;
	
	auto data = "Alan 37 Ria 41 Joel 35 Timothy 32 Mari 13 Lahtrell 4 Jeremy 21 Joy 49 Pop 69".split;
	foreach(i; iota(0, data.length, 2)) {
		ppl ~= Person(data[i], data[i+1].to!int);
	}
	
	writeln("File order:");
	each!writeln(ppl);
	writeln();
	
	writeln("Sorted from youngest:");
	each!writeln(ppl.sort!"a.age < b.age");
	writeln();

	writeln("Sorted from oldest:");
	each!writeln(ppl.sort!"a.age > b.age");
	writeln();	

	writeln("Sorted name length from longest:");
	each!writeln(ppl.sort!"a.name.length > b.name.length");
	writeln();	

	writeln("Sorted name length from shortest");
	each!writeln(ppl.sort!"a.name.length < b.name.length");
	writeln();
	
	writeln("Sorted name from A");
	each!writeln(ppl.sort!"a.name.toUpper < b.name.toUpper");
	writeln();

	writeln("Sorted name from Z");
	each!writeln(ppl.sort!"a.name > b.name");
	writeln();
	
	writeln("Show first letter values");
	foreach(psn; ppl) {
		writefln("%3s %s", psn.name[0].toUpper - 'A' + 1, psn);
	}
	writeln();
}