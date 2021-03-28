//Not work!
module stdxml;

import std.stdio;
import std.xml;
import std.datetime;

void benchmark (int iterations, immutable char[] content) {
	//auto elapsed = new HighPerformanceCounter();
	StopWatch elapsed;
	elapsed.start;
	
	for (auto i=0; ++i < iterations;) {
		check(content);
		writeln("A check done");
	}
	
	elapsed.stop;
	float timer = elapsed.peek().msecs / 1000.0;
	auto total = (content.length * iterations) / (timer * (1024 * 1024));
	write(total);
	writeln(" MB/s");
}

void main()
{
	immutable char[] content = import("esv.xml");
	for (int i = 2; --i;)
		benchmark (2, content);
}
