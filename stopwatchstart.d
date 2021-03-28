module dummy;

import std.stdio;
import std.datetime;
import core.thread;

void main() {
	StopWatch sw;
	void update(in ubyte id) {
		Thread.sleep(50.msecs);
		writeln(id, ") ", sw.peek.msecs);
	}
	update(1); // 0
	sw.start;
	update(2); // 53
	sw.reset;
	update(3); // 50
//	sw.start; // only use start once
}
