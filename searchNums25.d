// Done enroute from Cecily's to home
// 30 December 2014
void main() {
	int number = 15;
	int[] nums;
	nums.length = number;
	nums[] = -1;
	string line;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(nums[nc] != -1);
		nums[nc] = 1; // slot filled
		import std.conv;
		line ~= (nc + 1).to!string ~ ' ';
		if (line.length + 3 > 3 * 10 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}
