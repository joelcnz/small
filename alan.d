//# OS X
import std.stdio;
import std.process;
import std.string;

void sys(in string s) {
	wait(spawnShell(s));
}

void cls() {
	sys("clear");
}

void main(string[] args)
{
	cls;
	
	stepDown();
	sideWays();
	cls;
}

void stepDown() {
	int count = 0;
	stepDownAnimate("I went for a walk and fell down a hole!");
	stepDownAnimate("Alan Katherine Emily", /* uses hi */ true);
	
	stepDownAnimate("The quick brown fox jumps over the lazy dog!");
	stepDownAnimate("I gave Alan dominoes that were his before.");

	import core.thread;

	Thread.sleep(1_500.msecs);
	cls;
}

void stepDownAnimate(string str, bool usesHi = false) {
	import std.stdio;
	import std.string;
	import core.thread;
	import std.conv;
	
	foreach(name; str.split ~ " ") {
		if (usesHi) {
			if (name.length > 1)
				build(text("Hi, ", name, "!"));
		} else {
			build(name);
		}
		Thread.sleep(300.msecs);
	}
	cls;
}

void build(in string word) {
	import std.stdio;
	import core.thread;
	import std.algorithm;
	import std.range;

	if (word.length) {
		iota(word.length).
		map!((a) { write(word[0..a+1], "\r"); stdout.flush; Thread.sleep(100.msecs); return a; }).
		array;
		writeln;
	}
}

void sideWays() {
	sideWaysAnimate("Happy Birthday, Alan!");
}

void sideWaysAnimate(string message) {
	import std.range;
	import core.thread;
	
	int x = 1, dir = 1;
	int count = 0;
	while (count < 3) {
		' '.repeat.take(x).write(message, " \r"); stdout.flush;
		Thread.sleep(70.msecs);
		x += dir;
		if (x > 20 || x < 2)
			dir *= -1,
			count++;
		
	}
}
