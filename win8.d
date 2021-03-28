// 3.8.2012 On Windows 8 consumer preview - altered (not tried on Win 8) on 7 February 2015
import std.stdio;
import core.thread;

void main() {
	int x=0, dir = 1;
	foreach(count; 0 .. 7 * 40) {
		import std.range;
		import std.conv;
		write(' '.repeat.take(x).to!string ~ "Welcome to Windows 8 preview with D" ~ ' ' ~ "\r");
		stdout.flush();
		Thread.sleep(100.msecs);
		x += dir;
		if (x<1 || x > 40 - 1) // was x < 0, but it would stop (at the start when coming back) with ' '.repeat.take(x).to!string etc.
			dir *= -1;
	}
}
