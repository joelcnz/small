class Person {
	string name;
	int age;
	
	this(string name, int age) {
		this.name = name;
		this.age = age;
	}
	
	override string toString() {
		import std.string;
		return format("Name: %-8s Age: %s", name, age);
	}
}

void main() {
	import std.stdio: writeln;
	import std.string: split;
	import std.range: iota, array, take;
	import std.conv: to;
	import std.algorithm: map, sort, filter;
	
	auto data = "Mari 12 Lahtrell 4 Joy 59 Jeremy 21 Dad 68 Ria 41 Alan 37 Joel 35 Timothy 32".
				split;

	Person[] ppl;
	iota(0, data.length, 2).
	map!((a) {
		ppl ~= new Person(data[a], data[a + 1].to!int);
		
		return a;
	}).
	array;
	
	printAll(ppl);
	
	auto num = 1;
	ppl.
	map!((a) {
		a.name = num.to!string ~ a.name;
		num++;
		return a;
	}).
	array;
	
	printAll(ppl);
	
	writeln("\n" ~ "Print some. Oldest to youngest, under age 59, only 5 \\/");
	ppl.
	sort!"a.age > b.age".
	filter!"a.age < 59".
	take(5).
	map!((a) {
		writeln(a);
		
		return a;
	}).
	array;
	
	printAll("I went for a walk and fell down a hole!".split);
	printAll("The quick brown fox, jumps over the lazy dog!".split);
}

void printAll(T)(T[] list) {
	import std.algorithm: map, sort;
	import std.stdio: writeln;
	import std.range: array;
	import std.string: toLower;
	
	writeln("\n" ~ "Print All \\/");

	static if (!is(T == string)) {
		list.
		sort!"a.age > b.age".
		map!((a) {
			writeln(a);
			return a;
		}).
		array;
	} else {
		list.
		sort!"a.toLower < b.toLower".
		sort!"a.length < b.length".
		map!((a) {
			writeln(a);
			return a;
		}).
		array;
	}
}
