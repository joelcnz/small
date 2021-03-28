void main(string[] args) {
	enum Gate {closed, open}
	Gate[] gates;
	int number = 10; // defualt value
	
	bool numberOfAugumentsIsTwo() { return args.length == 2; }
	
	if (numberOfAugumentsIsTwo) {
		try {
			import std.conv;
			number = args[1].to!int;
		} catch(Exception e) {
			import std.stdio;
			writeln("Invalid number!");
			//writeln(e);
			return;
		}
	}
	number = 1 + number + 1;
	gates.length = number;
	string line;
	int[] nums;
	foreach(i; 1 .. number - 1) {
		int nc; // number candidate
		do {
			import std.random;
			nc = uniform(1, number - 1);
		} while(gates[nc] == Gate.open);
		gates[nc] = Gate.open;
		
		nums ~= nc;		
	}
	
	foreach(i, n; nums) {
		if (i > 0 && i % 10 == 0) {
			import std.stdio;
			writeln;
		}
		import std.stdio;
		write(n, ' ');
	}
	import std.stdio;
	writeln;
}
