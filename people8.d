import std.algorithm: sort, equal;
import std.string: format, split;
import std.range: iota;
import std.conv: to;
import std.stdio: writeln;

struct Person {
	string name;
	int age;
	
	auto toString() const {
		return format("%10s-%s", name, age);
	}
}

auto vold() {
	struct St { int name; int age; }
	St st;
	
	return st;
}

void main() {
	auto rawData = "Joel 35 Ria 42 Alan 38 Mari 12 Lahtrell 4 Dad 68 Joy 59 Jeremy 21".split;
	Person[] ppl;
	foreach(i; iota(0, rawData.length, 2)) {
		ppl ~= Person(rawData[i], rawData[i + 1].to!int);
	}
	
	void display(T)(T arr) {
		writeln(typeid(arr));
		foreach(psn; arr)
			writeln(psn);
		writeln;
	}

	display(ppl.sort!"a.age < b.age");

	display(ppl.sort!"a.age > b.age");
	
	auto t = vold;
	writeln(typeid(t));
}
