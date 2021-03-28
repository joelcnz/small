//#not work
void main() {
	import std.stdio;
	import std.algorithm.comparison : equal;
	import std.container : DList;

	struct Person {
		string name;
		int age;
	
		auto toString() {
			import std.conv : to;
			return "name: " ~ name ~ ", age: " ~ age.to!string;
		}
	}

	auto p = DList!Person(Person("Joel", 38), Person("Alan", 41));
	void pnt(in string title) {
		writeln(title);
		foreach(na; p)
			writeln(na);
		writeln;
	}
	pnt("Init");
	p.insertBack([Person("Timothy", 34), Person("Ria", 44)]);
	pnt("Added two more names to the back");
	
	import std.range;
	
//	for(auto rn = p[], i = 0; !rn.empty; i += 1)
//		if (i == 2)
			
	//p.popBackN(2);
	//p.insertBack([Person("Dad", 71), Person("Timothy", 34), Person("Ria", 44)]);
	
	//p.insert(2, Person("Dad", 71)); //#not work
	pnt("Insert inbetween (now how do you do that, I think you'd want to be able to insert ones while you're interating the list)");
}