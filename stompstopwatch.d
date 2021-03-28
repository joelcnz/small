// Stamp stamp 1.2.12
import std.stdio;
import std.array;
import std.datetime;

@property bool empty(T)(T[] a) { return a.length == 0; }
@property ref T front(T)(T[] a) { return a[0]; }
void popFront(T)(ref T[] a) { a = a[1..$]; }

void main(string[] args) {
	auto words = "I went for a walk and fell down a hole!".split;
	args.popFront;
	if (args.length)
		words = args[1..$];
	
	StopWatch sw;
	sw.start;
	bool done = false;
	while(!done) {
		if (sw.peek().msecs == 1_000 / 4) {
			if (words.empty) //if (words.length == 0)
				done = true; // set to exit
			else {
				sw.start;
				write(words.front, words.length > 1 ? " " : ""); // write(words[0], words.length > 1 ? " " : "");
				stdout.flush();
				words.popFront(); // words = words[1..$];
			}
		}
	}
	writeln();
}
