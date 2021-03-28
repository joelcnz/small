// Not finished!

enum SortType {name, age}

struct Person {
	string name;
	int age;
	SortType sortType = SortType.name;
	
	void setSortType(SortType newSortType) {
		sortType = newSortType;
	}

	int opCmp(Person psn) const {
		import std.string: toLower;

		final switch(sortType) {
			case SortType.name:
				if (psn.name.toLower < name.toLower)
					return 1;
				else if (psn.name.toLower > name.toLower)
					return -1;
				else
					return 0;
			break;
			case SortType.age:
				if (psn.age < age)
					return 1;
				else if (psn.age > age)
					return -1;
				else
					return 0;
			break;
		}
	}
	
	string toString() const {
		import std.string: format;
		return format("%10s-%s", name, age);
	}
}

void main() {
	Person[] ppl;
	auto rawData = "Joel 35 Timothy 32 Alan 38 Katherine 36 Neville 68 Jeremy 21 Mari 12 Lahtrell 4 Ria 41 Joy 59";
	import std.string: split;
	import std.range: empty, popFront, front, array;
	auto arr = rawData.split;
	while(! arr.empty) {
		Person p;
		p.name = arr.front;
		import std.conv: to;
		arr.popFront;
		p.age = arr.front.to!int;
		ppl ~= p;
		arr.popFront;
	}
	
	import std.stdio: writeln;
	import std.algorithm: each;
	ppl.each!writeln;
	
	writeln("---");
	import std.algorithm: sort;
	import std.string: toLower;
	ppl.each!((ref p) => p.setSortType(SortType.age));
	ppl.sort!"a < b";
	ppl.each!writeln;

	writeln("---");
	ppl.each!((ref p) => p.setSortType(SortType.name));
	ppl.sort!"a < b";
	ppl.each!writeln;

	writeln("---");
	auto joel = Person("Joel", 35);
	assert(binarySearch!Person(ppl, joel) == true);
	writeln;
}

bool binarySearch(T)(T[] input, T value) {
	import std.stdio: writeln, write;
	import std.range: empty;
//	void q(string label) {}
	void q(string label) {
		writeln(" ", label);
		foreach(i, a; input)
			write(a, (i == input.length - 1 ? "" : " "));
	}
	q("Start (looking for Joel)");
	while(! input.empty) {
		q("Top of loop");
		int i = cast(int)input.length / 2;
		T mid = input[i];
		q("Mid equals");
		if (mid > value)
			input = input[0 .. i],
			q("The left");
		else if (mid < value)
			input = input[i + 1 .. $],
				q("The right");
		else {
			import std.stdio; writeln;
			writeln(input[i], " Found!");
			return true;
		}
	}
	q("Not found!");
	return false;
}
