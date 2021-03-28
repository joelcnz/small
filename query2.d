// Init: Date: 26 12 2014

struct Person {
	string name;
	int age;
	
	string toString() {
		import std.string;
		return format("name %s  age %s", name, age);
	}
}

void main(string[] args) {
	Person[] ppl;
	// December 27 2014
	auto rawData = "Clutha 29 Fraser 23 Timothy 32 Ria 41 Alan 38 Joel 35 Katherine 36 Mari 12 Jeremy 21 Joy 59 Dad 68";
	import std.string;
	rawData ~= " " ~ args[1 .. $].join(" ");
	import std.stdio;
	writeln(rawData);
	import std.string;
	auto data = rawData.split;
	int number = cast(int)data.length;
	
	import std.range;
	foreach(i; iota(0, number, 2)) {
		import std.conv;
		ppl ~= Person(data[i], data[i + 1].to!int);
	}
	
	void print(in string caption) {
		import std.stdio;
		foreach(psn; ppl)
			writeln(psn);
		auto wing = '-'.repeat.take(3);
		writeln(wing, caption, wing, '\n');
	}
	
	print("Start off");
	
	ppl.
	sort!"a.age > b.age".
	sort!"a.name.length > b.name.length";
	
	print("Sort age and name length");
}
