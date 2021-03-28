struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string;
		return format("Name: %s, Age: %s", name, age);
	}
}

void main(string[] args) {
	import std.string;
	import std.algorithm: map, sort, filter;
	import std.range: iota, array, join, take;
	import std.conv: to;

	assert(join([[1, 2, 3], [4, 5]], [72, 73]) == [1, 2, 3, 72, 73, 4, 5]);

	Person[] ppl;
	string[] data;
	string initData = "Alan 37 Ria 41 Joel 35 Timothy 32 Mari 12 Lahtrell 4 Jeremy 21 Joy 49 Dad 68";
	if (args.length == 1) {
		data = initData.
			   split;
	} else {
		data = args[1..$].
			   join(" ").
			   split;
	}
	
	iota(0, data.length, 2).
	map!((a) {
		ppl ~= Person(data[a], data[a + 1].to!int);
		return a;
	} ).
	array;
	
	auto set = ppl.
		sort!"a.age > b.age".
		map!((a) => Person(a.name, a.age));
	
	import std.stdio;
	writeln("\n" ~ "All and sorted \\/");
	set.
	map!((a) { writeln(Person(a.name, a.age)); return a; }).
	array;	
	
	import std.typecons;
	auto set2 = ppl.
			sort!"a.age < b.age".
			filter!"a.age <= 40".
			take(6).
			map!((a) => tuple(a.name, a.age));
	
	writeln("\n" ~ "Sorted from youngest, and under 40, and only 6 people \\/");
	foreach(itm; set2)
		writeln(Person(itm[0], itm[1]));
}

/+
auto pop(T[])(T string s) {
	writeln(s);
	
	return 
}
+/