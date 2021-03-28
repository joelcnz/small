void main() {
	int number = 17;
	int[] nums = new int[number];
	nums[] = -1;
	string line;
	immutable MSEC_PAUSE = 700;

	void pause() {
		import core.thread;
		Thread.sleep(MSEC_PAUSE.msecs);
	}

	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(nums[nc] != -1);
		
		nums[nc] = i + 1;
		import std.conv;
		line ~= (nc + 1).to!string ~ " ";
		if (line.length + 3 > 3 * 10 || i == number - 1) {
			import std.stdio;
			pause;
			writeln(line);
			line.length = 0;
		}
	}
	
	pause;
	import std.stdio, std.algorithm;
	writeln(nums.sort!"a > b");
	pause;
	writeln(nums.sort!"a < b");
	pause;
}