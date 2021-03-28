void main(string[] args) {
	int number = 10;
	if (args.length == 2) {
		int line;
		int test;
		try {
			import std.conv;
			line = __LINE__; test = args[1].to!int;
		} catch(Exception e) {
			import std.stdio;
			writeln("Fatal error! In file: ", __FILE__, " at line ", line);
			return;
		}
	}
	int[] nums = new int[number];
	nums[] = -1;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(nums[nc] != -1);
		nums[nc] = i + 1;
	}
	
	import std.stdio;
	writeln(nums);
}