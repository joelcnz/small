import std.stdio;
import core.thread;
import std.range;

void main() {
	auto greeting = "Happy New Year, every one!";
	
	foreach(x; 0 .. greeting.length) {
		if (greeting[x] != ' ')
			Thread.sleep(200.msecs);
		write(greeting[0 .. x], "\r"); stdout.flush;
	}
}
