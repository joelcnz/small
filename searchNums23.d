// I don't think it scales well
void main(string[] args) {
	int number;
	int[] nums;

	void setUp() {
		number = 20;
		if (args.length > 1) {
			import std.conv;
			int test;
			int line;
			try {
				line = __LINE__; test = args[1].to!int;
			} catch(Exception e) {
				import std.stdio;
				writeln("Fatal error: ", e, " Error trying to convert to a number see file ", __FILE__, " line: ", line);
				return;
			}
			number = test;
		}
		nums = new int[number];
		nums[] = -1;
	}
	setUp;

	int getRndNum() {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(nums[nc] != -1);

		return nc;
	}

	foreach(i; 0 .. number) {
		nums[getRndNum] = i+1;
	}
	
	import std.stdio;
	writeln(nums);
}
