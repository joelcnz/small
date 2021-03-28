void main(string[] args) {
	int msecsTime;
	import std.file;
	import std.conv;
	import std.stdio;
	msecsTime = readText("searchNums.txt").to!int;
	if (args.length == 2)
		File("searchNums.txt", "w").write(args[1].to!int);

	if (args.length > 1) {
		import std.conv;
		msecsTime = args[1].to!int;
	}
	int number = 30;
	enum Gate {SHUT, OPEN}
	Gate[] gates;
	int[] nums;
	gates.length = number; // all gates start shut
	string line;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(gates[nc] == Gate.OPEN);
		gates[nc] = Gate.OPEN;
		import std.string;
		nums ~= nc + 1;
		line ~= format("%s ", nc + 1);
		if (line.length > 3 * 30 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}

	void print() {
		foreach(n; nums) {
			import std.stdio;
			import std.range;
			writeln('#'.repeat.take(n), n);
		}
	}
	
	int bullit;
	alias targets = nums;
	foreach(i, target; targets) {
		while(bullit != target) {
			if (bullit < target)
				bullit++;
			else if (bullit > target)
				bullit--;
			void graph() {
				import std.stdio;
				import std.range;
				write((target < 10 ? "0" : ""), target, '='.repeat.take(bullit), (bullit < 10 ? "0" : ""), bullit, ' '.repeat.take(number - bullit), "\r");
				stdout.flush;
			}
			graph;
			import core.thread; 
			Thread.sleep(msecsTime.msecs);
		}
		import std.stdio;
		writeln;
	}
	
	print;
}
