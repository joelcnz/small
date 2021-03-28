struct Student {
	string name;
	int grade;

	auto toString() const {
		import std.string;
		
		return format("Name: %10s, Grade: %s", name, grade);
	}
}

struct School {
	Student[] students;
		
	@property bool empty() { return students.length == 0; }
	@property auto front() { return students[0]; }
	void popFront() { students = students[1 .. $]; }
}

void main() {
	import std.stdio : writeln;
	import std.string;
	auto names = "Alan Timothy Joel Ria".split;
	auto ages = [50, 60, 40, 30];
	immutable size_t length = names.length;
	School school;
	school.students.length = length;
	foreach(i; 0 .. length) {
		school.students[i] = Student(names[i], ages[i]);
	}

	import std.range : iota;
	import std.algorithm : each;
	iota(2).
	each!(a => {
		writeln("#", a + 1);
		foreach(student; school)
			writeln(student);
		writeln;
	}());
}
