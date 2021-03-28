void main(string[] args) {
	int number = 10;
	if (args.length == 2) {
		try {
			import std.conv;
			number = args[1].to!int;
		} catch(Exception e) {
			import std.stdio;
			writeln("Invalid number! Continue happily..");
		}
	}
	enum Gate {closed, open}
	Gate[] gates;
	int[] nums;
	gates.length = nums.length = number;
	string line;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(1, number + 1);
		} while(gates[nc - 1] == Gate.open);
		
		import std.string;
		line ~= format("%s ", nc);
		nums[i] = nc;
		if (line.length > 10 * 3 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
		gates[nc - 1] = Gate.open;
	}
}