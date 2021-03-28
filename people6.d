struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string: format;
		return format("%10s-%s", name, age);
	}
}

void main() {
	Person[] ppl;
	auto rawData = "Joel 35 Ria 42 Alan 38 Timothy 32 Mari 12 Lahtrell 4 Joy 59 Jeremy 21 Neville 68";
	import std.string: split;
	auto data = rawData.split;
	import std.range: iota;
	import std.conv: to;
	foreach(i; iota(0, data.length, 2)) {
		ppl ~= Person(data[i], data[i+1].to!int);
	}
	
	import std.algorithm: sort;
	ppl.sort!"a.age < b.age";
	foreach(psn; ppl) {
		import std.stdio: writeln;
		writeln(psn);
	}
}
