void main(string[] args) {
	int number = 10;
	if (args.length == 2) {
		try {
			import std.conv;
			number = args[1].to!int;
		} catch(Exception e) {
			import std.stdio;
			writeln("Some thing went WRONG!");
			return;
		}
	}
	
	enum Slot {closed, open}
	
	Slot[] slots;
	string line;
	slots.length = number;
	
	int getNumber(ref Slot[] slots) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(1, number + 1);
		} while(slots[nc - 1] == Slot.open);
		
		slots[nc - 1] = Slot.open;
		
		return nc;
	}
	
	void addNumber(in int index, ref string line, in int nc) {
		import std.string;
		line ~= format("%s ", nc);
		if (line.length > 10 * 3 || index == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
	
	import std.range;
	number.
	iota.
	map!((i) {
		immutable nc = getNumber(slots);
		addNumber(i, line, nc);
		
		import std.stdio;
		
		return i;
	} ).
	array;
}
