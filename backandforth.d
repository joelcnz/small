import std.stdio;
import core.thread;
import std.range;
//import std.array;

void main() {
	bool forward;
	forward = true;
	int x;
	x =0;
	
	writeln("While holding Ctrl key down, tap the C key");
	
	while(true) {
		final switch(forward) {
			case true:
				x = x + 1;
			break;
			case false:
				x = x - 1;
			break;
		}
		
		if (0 == x || 40 == x)
			forward = ! forward;
			
		write(' '.repeat.take(x));
		write('*');
		write(' '.repeat.take(40 - x));

		Thread.sleep(50.dur!"msecs");

		write('\r');
		stdout.flush();
		
	} // while true
}
