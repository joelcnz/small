enum Gate {close, open}

void main(string[] args) {
	int number;
	Gate[] gates;
	if (! setUp(args, number, gates)) {
		return;
	}
	run(number, gates);
}

bool setUp(string[] args, ref int number, ref Gate[] gates) {
	import std.conv;
	if (args.length == 2) {
		try {
			number = args[1].to!int;
		} catch(Exception e) {
			import std.stdio;
			writeln("Invalid number!");
			return false;
		}
		} else {
			number = 10;
		}
	number = 1 + number + 1;
	gates.length = number;
	
	return true;
}

void run(in int number, ref Gate[] gates) {
	string line;
	foreach(i; 1 .. number - 1) {
		int rc;
		do {
			import std.random;
			rc = cast(int)uniform(1, number - 1);
		} while(gates[rc] == Gate.open);
		gates[rc] = Gate.open;
		
		import std.string;
		line ~= format("%s ", rc);
		
		if (line.length > 3 * 10 + 3 || i == number - 2) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
	
}
