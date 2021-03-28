// Only one mistake, retyping this from memory, (I put 'import std.conv' instead of 'import std.random' version 1.0
void main() {
	int number = 20;
	int[] nums;
	nums.length = number;
	nums[] = -1;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(nums[nc] != -1);
		nums[nc] = i;
	}
	++nums[];
	
	import std.stdio;
	writeln("nums ", nums);
}
