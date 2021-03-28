import std.stdio;
import std.container;
import core.memory, core.stdc.stdlib, core.stdc.string, std.algorithm,
    std.conv, std.exception, std.functional, std.range, std.traits,
    std.typecons, std.typetuple;

void main() {
	auto a = DList!int(1,2,3);

	void display() {
		auto hold = a.dup;
		int[] l;
		scope(exit)
			writeln(l),
			a = hold;
		while(! a.empty) {
			l ~= a.front;
			a.removeFront;
		}
	}

	display();
	
	a.insert([7,6,5]);
	display();

	foreach(e; a)
		write(e, ' ');
	writeln();
	writeln("Reverse:");
	foreach_reverse(e; a)
		write(e, ' ');
	writeln();
	
	a.insertFront([10,30,20]);
	writeln(a[].reverse);

    auto dl = DList!string(["a", "b", "d"]);
    dl.insertAfter(dl[], "e"); // insert at the end
    assert(equal(dl[], ["a", "b", "d", "e"]));
    auto dlr = dl[];
    writeln(dlr);
    dlr.popBack(); dlr.popBack();
    writeln(dlr);
    dl.insertAfter(dlr, "c"); // insert after "b"
    writeln(dlr);
    assert(equal(dl[], ["a", "b", "c", "d", "e"]));
    
    auto units = DList!Unit();
    units.insert([new Tank("Tank 001", 0,0), new APC("APC 001", 8, 0)]);
    foreach(unit; units)
		writeln(unit);
	writeln("---");
	units.insert([new Tank("Tank 002", 16, 0)]);
    foreach(unit; units)
		writeln(unit);
}

class Unit {
	int xpos, ypos;
	string name;
	this(string n, int x, int y) {
		name = n;
		xpos = x;
		ypos = y;
	}
	
	override string toString() {
		return text("name: ", name, " - x = ", xpos, " y = ", ypos);
	}
}

class Tank: Unit {
	this(string n, int x, int y) {
		super(n, x, y);
	}
}

class APC: Unit {
	this(string n, int x, int y) {
		super(n, x, y);
	}
}
