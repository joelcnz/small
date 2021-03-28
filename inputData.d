//#not working properly
import std.stdio: readf, readln;
import std.string: chomp, split;
import std.conv: to;

struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string: format;
		return format("%10s-%s", name, age);
	}
}

void main() {
	Person[] ppl;
	Person psn;
	import std.stdio: writeln;
	writeln("Enter eg. Joel 35 Timothy 32 e -1");
	do {
		bool exceptAdd = true;
		//#not working properly
		try {
			auto rawData = readln.chomp; //psn.age; 
			if (rawData.split.length % 2 != 0)
				break;
			psn.name = rawData.split[0];
			psn.age = rawData.split[1].to!int;
			writeln(psn);
		} catch(Exception e) {
			import std.stdio: writeln;
			writeln("Oops, try again.");
			exceptAdd = false;
		}
		
		if (psn.age == -1) {
			exceptAdd = false;
		}

		if (exceptAdd)
			ppl ~= psn;
	} while(psn.age != -1);
	
	import std.stdio: writeln;
	writeln;
	writeln("Data:");
	import std.algorithm: sort;
	foreach(e; ppl.sort!"a.age > b.age") {
		writeln(e);
	}
}
