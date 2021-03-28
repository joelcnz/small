struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string;
		return format("%s %2s", name, age);
	}
}

void main(string[] args) {
	Person[] ppl;
	auto rawData = "Joel 35 Alan 38 Dad 68 Ria 41";
	import std.string: join, split;
	import std.stdio;
	rawData ~= " " ~ args[1..$].join(" ");
	auto data = rawData.split;
	auto dataLength = data.length;
	import std.range: iota;
	import std.conv: to;
	writeln(data);
	foreach(i; iota(0,dataLength,2))
		ppl ~= Person(data[i], data[i+1].to!int);
	
	import std.algorithm: sort;
	foreach(psn; ppl.sort!"a.age > b.age")
		writeln(psn);
}
