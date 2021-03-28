import std.stdio;
import std.process;
import std.datetime;
import core.thread;
import std.conv;

void main() {
	auto frames = [
[" 0 ",
 "0 0",
 "0 0",
 "0 0",
 " 0 "],
[" 1 ",
 "11 ",
 " 1 ",
 " 1 ",
 "111"],
["222",
 "  2",
 " 2 ",
 "2  ",
 "222"],
["333",
 "  3",
 " 33",
 "  3",
 "333"],
["4 4",
 "4 4",
 "444",
 "  4",
 "  4"],
["555",
 "5  ",
 "55 ",
 "  5",
 "55 "],
[" 66",
 "6  ",
 "66 ",
 "6 6",
 "66 "],
["777",
 "  7",
 "  7",
 " 7 ",
 " 7 "],
["888",
 "8 8",
 " 8 ",
 "8 8",
 "888"],
[" 99",
 "9 9",
 " 99",
 "  9",
 "  9"],
[" 0 ",
 "0 0",
 "0 0",
 "0 0",
 " 0 "]
];

version(all) {
	foreach(block; frames) {
		foreach(layer; block)
			writeln(layer);
		Thread.sleep(dur!"msecs"(200));
		system("clear");
	}
	foreach_reverse(block; frames) {
		foreach(layer; block)
			writeln(layer);
		Thread.sleep(dur!"msecs"(200));
		system("clear");
		//executeShell("clear"); // not do the thing
	}
}

	// Not work
version(none) {
	auto num = "1979";
	foreach(l; 0..5) {
		writeln(frames[l][ num[0].to!int() ], ' '
		      , frames[l][ num[1].to!int() ], ' '
		      , frames[l][ num[2].to!int() ], ' '
		      , frames[l][ num[3].to!int() ], ' ');
	}
} // version	
}

