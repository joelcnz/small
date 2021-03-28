struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string;
		return format("Name: %s, \tAge: %-4s", name, age);
	}
}

void main() {
	Person[] ppl;
	
	ppl ~= Person("Brook", 8);
	ppl ~= Person("Joel", 183);
	ppl ~= Person("Wolf", 1_000);
	
	import std.stdio : writeln;
	import std.algorithm : each;
	ppl.each!writeln;
}