//# not work
struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string;
		import std.range;
		return format("%10s  %2s: %s", name, age, "#".replicate(age));
	}
}

void main(string[] args) {
	string rawData;
	string[] data;
	Person[] ppl;

	void setUp() {
		rawData = "Joel 35 Ria 41 Alan 38 Katherine 36 Timothy 32 Mari 12 Lahtrell 4";
		if (args.length > 1) {
			import std.string;
			rawData ~= " " ~ args[1..$].join(" ");
		}
		import std.string;
		data = rawData.split;
	}
	setUp;
	
	void process() {
		import std.range;
		import std.conv;
		foreach(i; iota(0, data.length, 2)) {
			ppl ~= Person(data[i], data[i+1].to!int);
		}
	}
	process;
	
	void test() {
		void print(in string caption) {
			import std.stdio;
			foreach(psn; ppl) {
				import std.range;
				writeln(psn);
			}
			immutable newLine = "\n";
			writeln(" -", caption, "-", newLine);
		}
		
		import std.algorithm;
		import std.range;
		
		print("Unprocessed");
		
		ppl
		.sort!"a.age > b.age";
		
		print("Ages higher (greater age) to lower (lesser age)");
	}
	test;
	
	void other() {
		import std.algorithm: sort, filter, map;
		import std.stdio;
		import std.typecons: tuple;
		
		auto select = ppl.
			sort!((a, b) => a.name[0] < b.name[0]).
			filter!(a => a.age > 30 && a.age < 70).
			map!(a => tuple(a.name, a.age));
		
		//select[0].name = "Bob"; //# not work
		foreach(person; select)
			writeln(Person(person[0], person[1]));
			
	}
	other();
}
