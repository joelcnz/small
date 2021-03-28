import std.stdio;

struct Try {
	string name;
	long age;
	
	void toString(void delegate(string) sink) {
		import std.string;
		sink(format("Name: %s, Age: %s", name, age));
	}
}

void main() {
	Try t = Try("Joel", 35);
	t.toString(c => writeln(c));
}
