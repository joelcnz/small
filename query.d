struct Person {
	string name;
	int age;

	string toString() const {
		import std.string;
		return format("name %s  age %s", name, age);
	}
}

void main(string[] args) {
	import std.stdio;
	writeln;
	
	Person[] ppl;
	import std.string;
	auto rawData = "Mari 12 Alan 38 Joel 35 Katherine 36 Timothy 32 Lahtrell 4 Dad 68 Joy 59 Jeremy 21";
	if (args.length > 1) {
		writeln("Apple laptop");
		foreach(arg; args[1 .. $]) /* more raw data */
			rawData ~= " " ~ arg;
	}
	
	writeln("Enter your name and age eg 'Joel 35'");
	rawData ~= " " ~ readln;
	
	auto data = rawData.split;
	
	import std.range;
	import std.conv;
	import std.algorithm;

	writeln("Apple Ear phones");
	int i;
	iota(0, data.length, 2)
	.map!((a) {
		ppl ~= Person(data[i], data[i+1].to!int);
		i += 2;

		return a;
	})
	.array;

	void print(in string title) {
		import std.stdio;
		writeln(title);
		foreach(psn; ppl)
			writeln(psn);
		writeln;
	}
	
version(CordindOff) {
	print("Start..:");
	
	ppl.
	sort!"a.age > b.age";
	print("Sort by age descending..:");
	
	ppl.
	sort!"a.age < b.age";
	print("Sort by age ascending..:");
	
	ppl.
	sort!"a.name > b.name";
	print("Sort by name descending..:");
		
	ppl.
	sort!"a.name < b.name";
	print("Sort by name ascending..:");
	
	ppl.
	sort!"a.name.length > b.name.length";
	print("Sort by name length descending");
} // version

	ppl.
	sort!"a.name < b.name".
	sort!"a.name.length < b.name.length";
	print("Sort by name length aescending");

	// This works too
	version(Extra) {
		auto sortBy = cast(immutable char[])"a.age > b.age";
		ppl.
		sort!sortBy;
		print("Extra..:");
	}
}
