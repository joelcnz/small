void main(string[] args) {
	int[] nums;
	import std.conv;
	
	void errorMessage() {
		import std.stdio;
		writeln("Fatal error, try again!");
	}

	if (args.length != 2)
		return errorMessage();
	try {
		nums.length = 1 + args[1].to!int + 1;
	} catch(Exception e) {
		return errorMessage();
	}

	import std.stdio;
	writeln("Search Numbers 1 - ", nums.length - 2);

	enum Gate: bool {open, closed}
	Gate[] gates;
	auto numberLine = "";
	gates.length = nums.length;
	gates[] = Gate.closed;
	import std.range;
	foreach(i; iota(1, nums.length - 1)) {
		int rc;
		do {
			import std.random;
			rc = cast(int)uniform(1,nums.length - 1);
			
		} while(gates[rc] == Gate.open);
		gates[rc] = Gate.open; // so you can see the number, it was hiding
		
		import std.string;
		numberLine ~= format("%s ", rc);
		if (numberLine.length + 3 > 10 * 3 || i == nums.length - 2) {
			import std.stdio;
			
			writeln(numberLine);
			numberLine.length = 0;
		}
	}
}
