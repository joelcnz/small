struct Person { //#yay! Got it to work
	string name;
	long age;
	
	string toString() {
		import std.string;
		return format("Name: %8s, Age: %s", name, age);
	}
}

void main(string[] args) {
	import std.string: join, split;

	auto data = args[1..$];

	import std.range: iota;
	import std.conv: to;
	import std.stdio: writeln;

	Person[] ppl;
	//"Joel 35 Timothy 32"
	version(none) {
	foreach(itx; iota(0,data.length, 2)) {
		ppl ~= Person(data[itx],
					  data[itx + 1].to!long);
	}
	} // version
	
	import std.algorithm: filter, sort, map, take;
	import std.array: array;

	iota(0, data.length, 2).
	map!((a) { ppl ~= Person(data[a], data[a+1].to!long); return a; }).
	array;
	
	ppl.
	sort!"a.age > b.age"; // ppl stays sorted

	writeln("\n" ~ "UFC - Unified Function Call..");

	ppl.
	take(5).
	map!((a) { writeln(a); return a; } ).array; //#yay! Got it to work
	
	import std.stdio: writeln;
	writeln("\n" ~ "Display all:");
	foreach(psn; ppl)
		writeln(psn);
	writeln;

	auto ageRange = 40; // int
	writeln(typeid(ageRange));
	writeln("\nJust people over ", ageRange, ":");
	
	ppl.
	filter!(a => a.age > ageRange).
	map!((a) { writeln(a); return a; }).
	array;
		
	writeln("\nJust J names:");
	ppl.
	filter!"a.name[0] == 'J'".
	map!((psn) { writeln(psn); return psn; }).
	array;
}

/*
string list(Person[] ppl) {
	string result;
	
}
*/ 