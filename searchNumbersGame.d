void main(string[] args) {
	int number;

	import std.stdio;
	import std.conv;
	import std.file;
	import std.string;
	auto numsStr = readText("nums2.txt");
	number = cast(int)numsStr.split.length;
	auto nums = numsStr.split.to!(int[]);
	
	import std.algorithm;
	import std.range;

	string snums;
	nums.each!(n => snums ~= text(n, ' '));
	write(snums[0 .. $ - 1]);
	
	auto getSeconds(long msecs) {
		return format("%s.%03s", msecs/1000, msecs % 1000);
	}

	import std.stdio;
	import std.process;
	wait(spawnShell("clear"));
	write("\nPress enter each time you find the next number (Go!):");
	import std.datetime;
	StopWatch total, each;
	total.start;
	long[] speeds;
	bool quitEarly = false;
	foreach1: foreach(i; 0 .. number) {
		each.reset;
		each.start;
		auto input = readln;
		if (input.length && input[0] == 'q') {
			quitEarly = true;
			break foreach1;
		}
		speeds ~= each.peek.msecs;
		writef("%2s: %s seconds", i + 1, getSeconds(speeds[$-1]));
	}
	total.stop;
	
	if (! quitEarly) {
		long minTime;
		minTime = reduce!((a, b) => a < b ? a : b)(long.max, speeds);

		long maxTime;
		maxTime = reduce!((a, b) => a > b ? a : b)(long.min, speeds);

		writefln("\nMin time: %s\nMax time: %s", getSeconds(minTime), getSeconds(maxTime));

		auto msecs = total.peek.msecs;
		writefln("\nTotal: %s seconds", getSeconds(msecs));
	} else {
		writeln("Never mind!");
	}
}
