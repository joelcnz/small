import std.string;
import std.algorithm;
import std.conv;
import std.range;
import std.stdio;

struct Person {
	string name;
	long age;
	
	string toString() const {
		import std.string;
		return format("Name: %10s, Age: %0s", name, age);
	}
}

void main(string[] args) {
	
	Person[] ppl;
	auto data = "Joel 35 Alan 37 Timothy 32 Ria 40 Lahtrell 4 Mari 12 Jeremy 21".split;

	foreach(index; iota(0, data.length, 2))
		ppl ~= Person(data[index], data[index + 1].to!long);

	writeln("File order");
	each!writeln(ppl);
	writeln();

	writeln("Sorted:");
	each!writeln(ppl.sort!"a.age > b.age");
	writeln();

	writeln("(new) Sorted, filtered take 2");
	import std.typecons;
	ppl
		.sort!"a.age < b.age"
		.filter!((a) => a.name != "Ria")
		.take(2)
		.map!((a) => Person(a.name, a.age))
		.each!writeln;

	writeln;
	writeln("Sorted, filtered, and dropped");
	auto set = ppl.
	sort!"a.age < b.age".
	filter!`a.name != "Ria"`.
	drop(2).
	map!((a) => tuple(a.name, a.age));

//	foreach(psn; set)
//		writeln(Person(psn[0],psn[1]));
	each!writeln(set);
}


