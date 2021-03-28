struct Person {
	string name;
	int age;
	
	auto toString() const {
		import std.string;
		return format("%02s age name %s\n", age, name);
	}
}

void main(immutable(char)[][] args) {
	Person[] ppl;
	auto rawData = "Joel 35 Joy 59 Jeremy 21 Mari 12 Dad 68 Alan 38 Ria 41 Timothy 32";
	
	import std.string;
	auto data = rawData.split;
	import std.range;
	import std.conv;
	foreach(i; iota(0, data.length, 2)) {
		ppl ~= Person(data[i], data[i+1].to!int);
	}
	
	import std.stdio;
	writeln(ppl);
}
