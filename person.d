class Person {
public:
	@property {
		string name() { return _name; }
		int age() { return _age; }
	}
	
	this(in string name, in int age) {
		_name = name;
		_age = age;
	}
	
	override string toString() const {
		import std.string;
		return format("%10s name age %2s", _name, _age);
	}
private:
	string _name;
	int _age;
}

void main(string[] args) {
	import std.range: popFront;
	args.popFront;
	
	auto rawData = "Joel 35 Timothy 32 Alan 38 Ria 41 Mari 12 Lahtrel 4 Joy 59 Jeremy 21 Neville 68 Katherine 36";
	import std.stdio; writeln;
	writeln(rawData);

	import std.string: join;
	if (args.length)
		rawData ~= " " ~ args.join(" ");
	writeln(rawData);

	import std.string: split;
	auto data = rawData.split;

	import std.range: iota;
	import std.conv: to;
	Person[] ppl;
	foreach(i; iota(0, data.length, 2)) {
		ppl ~= new Person(data[i], data[i+1].to!int);
	}
	import std.algorithm: sort;
	
	writeln("Sorting:");
	writeln("By oldest to youngest:");
	foreach(psn; ppl.sort!"a.age > b.age")
		writeln(psn);
	writeln;

	writeln("By name:");
	foreach(psn; ppl.sort!"a.name[0] < b.name[0]")
		writeln(psn);
	writeln;

	import std.range: filter, take;
	writeln("Filter out 30 and over:");
	foreach(psn; ppl.sort!"a.age > b.age".filter!"a.age < 30")
		writeln(psn);
	
	writeln;
	writeln("Oldest to youngest first 5 and filter out 50 or older");
	foreach(psn; ppl.sort!"a.age > b.age".filter!"a.age < 50".take(5))
		writeln(psn);
}
