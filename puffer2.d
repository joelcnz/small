import std.stdio;
import core.thread;
import std.file;
import std.conv;
import std.string;

void main(string[] args) {
	if (args.length > 2 && args[1].toLower == "reset") {
		std.file.write("puffer2dat.txt", 1.to!string);
		writeln("Puffer ", args[1], "!");
		
		return;
	}
	
	int puffs = readText("puffer2dat.txt").to!int;

	void waitASecond() {
		Thread.sleep(1.seconds);
	}

	int count = 1;
	void display() {
		write(count, '\r'); stdout.flush;
	}
	writeln("Puff number ", puffs);
	puffs++;
	if (puffs >= 6 + 1) //>=,I think is obsollet(sp)
		puffs = 1;
	std.file.write("puffer2dat.txt", puffs.to!string);
	
	display;
	bool done = false;
	while(! done) { // count to 60
		waitASecond;
		if (count == 1) //60) //1)
			done = true;
		else {
			count++;
			display;
		}
	}

	writeln("\nOver time.. (Ctrl+C) to stop");
	
	count = 0;
	while(true) {
		display;
		waitASecond;
		count++;
	}
}