//#UFCS
//#delegate written here is needed
//#look, no delegate
//#regex, I don't get it.
module small;

// Thought they said they've moved the aa to library
// What would they use instead of 'new' if they remove it?
import std.stdio;

class Cat {}
class Dog {}

void main() {
	Cat cat = cast(Cat)new Dog();
	writeln(cat is null);
	
	string[string] test;
	test["House Key"]="house";
	test["Shed Key"]="shed";
	foreach(k,v;test)
		writeln(k," for ",v);

//	version(none)
		more();
}

import std.conv;
import std.regex;
import std.stdio;
import std.string;

struct Data {
	string name;
	string phone;
	int age;
//	... // a whole bunch of other stuff
}

//#org: H. S. Teoh - http://forum.dlang.org/thread/mailman.1953.1334894800.4860.digitalmars-d@puremagic.com
void more() {
	Data d;
	foreach (line; stdin.byLine()) {
		//#regex, I don't get it.
		auto m = match(line, `(\w+)\s+(\w+)`);
		if (!m) continue;

		auto key = m.captures[1].idup;
		auto value = m.captures[2].idup;

		alias void delegate(string key, string value) attrDg;
		attrDg[string] dgs = [
			"name": delegate(string key, string value) {
				d.name = value;
			},
			"phone": (key, value) { d.phone = value; }, //#look, no delegate
			"age" : (key, value) { d.age = value.to!int; } // knocked off '()' too

//			...	// whole bunch of other stuff to
				// parse different attributes
		];
		attrDg errordg = delegate(string key, string value) { //#delegate written here is needed
			throw new Exception("Invalid attribute '%s'".format(key)); // added new for it to work.
		};

		// This is pure awesomeness:
		dgs.get(key.idup, errordg)(key.idup, value.idup);
	}
	// ... do something with Data
}

/+
//#UFCS
written to use UFCS of course:

    auto m = line.match("(\w+)\s+(\w+)");

    ...

    "age" : (key, value) { d.age = value.to!int(); }

:D gotta love UFCS!
+/
