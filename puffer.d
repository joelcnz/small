import std.stdio;
import core.thread;

void main() {
	bool turn(int puffs) {
		void displayCount(int n, string note = " counting..") {
			write('\r', n, note);
			stdout.flush;
		}
		void count(int n, string note = " counting..") {
			Thread.sleep(1.seconds);
			displayCount(n, note);
		}
		writeln("Puff number ", puffs);
		displayCount(0);
		foreach(n; 1 .. 60 + 1) { //# change to 1 + 1 for testing
			count(n);
		}
		if (puffs < 6) {
			writeln("And off we go again :-)");
			writeln("Enter 'q' to quit, (or Ctrl + C). Enter to continue.");
		}
			
		if (puffs == 6)
			writeln("And we're done! :-)");
		
		return puffs == 6;
	} // turn
	
	string input;
	int puffs = 1;
	bool finished = false;
	bool done = true;
	
	writeln("Press [return] to start..");
	readln;
	
	while(! finished) {
		import std.string;
		if (turn(puffs++) == done) {
			finished = true;
			break;
		}
		input = readln.chomp;
		if (input.length > 0 && input[0].toUpper == 'Q')
			finished = true;
	}
}
