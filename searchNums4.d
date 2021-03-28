void main(string[] args) {
	int number;
	enum Gate: bool {closed, open}
	Gate[] gates;
	import std.conv;
	if (args.length == 2) {
		try {
			gates.length = 1 + args[1].to!int + 1;
		}
		catch(Exception e) {
			import std.stdio;
			writeln("Number convert fail! Continue happily..");
			gates.length = 20;
		}
	} else {
		gates.length = 20;
	}
	number = cast(int)gates.length - 2;
	auto line = "";

	foreach(i; 1 .. gates.length - 1) {
		int rc;
		do {
			import std.random;
			rc = cast(int)uniform(1, gates.length - 1);
		} while(gates[rc] == Gate.open);
		gates[rc] = Gate.open;
		import std.string;
		line ~= format("%s ", rc);
		if (line.length + 3 > 10 * 3 || i == gates.length - 2) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}
