import std.stdio;
import std.range;
import core.thread: Thread, dur, msecs, seconds;

alias milliseconds = dur!"msecs";

void main() {
	writeln("Rocket to the moon!");
	Thread.sleep(1.seconds); //( milliseconds(1_000) );
	foreach( number; iota(/* beginning: */ 10, /* end: */ 0, /* step: */ -1) ) {
		writeln("Count down: ", number );
		if (number > 0)
			Thread.sleep(300.msecs);
	}
	writeln("Blast off!");
	
	Thread.sleep(2.dur!"seconds");
	writeln("Moon landing!");
	Thread.sleep(1.seconds);
}

