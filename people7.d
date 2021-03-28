struct Person {
	string name;
	int age;
	
	string toString() {
		import std.string: format;
		return format("%10s-%s", name, age);
	}
}

void main() {
	import std.string: split;
	auto rawNamesData = "Joel Alan Timothy Ria Dad Joy Jeremy";
	auto rawAgesData = "35 38 32 42 68 59 21";
	Person[] ppl;
	ppl.length = rawNamesData.split.length;
	foreach(i, name; rawNamesData.split)
		ppl[i].name = name;
	import std.conv: to;
	foreach(i, age; rawAgesData.split.to!(int[]))
		ppl[i].age = age;

	void print(T)(string title, T[] arr) {
		import std.stdio: writeln;
		writeln(title);
		foreach(e; arr)
			writeln(e);
		writeln;
	}
	print("Raw:", ppl);
	import std.algorithm: sort, filter;
	import std.range: array;
	print("Sort by age:", ppl.sort!"a.age < b.age".array);
	print("Sort by name length:", ppl.sort!"a.name.length < b.name.length".array);
	auto ints = [4,7,-6,3,6,2,-1,-5];
	print("Unprocessed numbers:", ints);
	print("Processing:", ints.copy.sort!"a < b".filter!"a >= 0".array);
	print("Processing (sort and filter):", ints.sort!"a < b".filter!"a < 0".array);
}
