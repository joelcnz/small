struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string: format;
		return format("%10s %s", name, age);
	}
}

auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront) {
		T value = arr.front;
		if (dg(value))
			arr2 ~= value;
	}
	return arr2;
}

void main(string[] args) {
	import std.range: popFront;
	args.popFront;
	Person[] ppl;
	ppl ~= Person("Joel", 35);
	ppl ~= Person("Katherine", 36);
	ppl ~= Person("Alan", 38);
	ppl ~= Person("Ria", 41);
	ppl ~= Person("Timothy",32);
	ppl ~= Person("Mari", 12);
	ppl ~= Person("Joy", 59);
	ppl ~= Person("Jeremy", 21);
	ppl ~= Person("Lahtrell", 4);
	ppl ~= Person("Neville", 68);
//	ppl ~= Person("",);

	import std.range: empty, popFront, front;
	import std.stdio: writeln;
	writeln("To start with:");
	auto ppl2 = ppl;
	for(; ! ppl2.empty; ppl2.popFront)
		writeln(ppl2.front);

	import std.stdio: writeln;
	import std.algorithm: sort;
	import std.range: array;
	writeln("\nShow ones less then 40 and age order from youngest to oldest:");
	foreach(psn; filt!Person(a => a.age < 40, ppl.sort!"a.age < b.age".array)) {
		writeln(psn);
	}
}
