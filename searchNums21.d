void main() {
	int number = 20;
	int[] nums;
	nums.length = number;
	nums[] = -1;
	int dingCnt = 0;
	foreach(i; 0 .. number) {
		int nc;
		bool done;
		do {
			import std.random;
			done = true;
			nc = cast(int)uniform(0, number);
			if (nums[nc] != -1) {
				done = false;
				import std.stdio;
				write("Ding! ");
				dingCnt++;
			}
			import core.thread;
			import std.stdio;
			stdout.flush;
			Thread.sleep(500.msecs);
		} while(! done);
		nums[nc] = i + 1;
	}
	import std.stdio;
	writeln("\nDing count: ", dingCnt);
	
	import std.stdio;
	writeln(nums);
}