void main(string[] args) {
	int frameTimeMsecs = 200; // 500 default
	if (args.length == 2) {
		import std.conv;
		try {
			frameTimeMsecs = args[1].to!int;
			
		} catch(ConvException e) {
			import std.stdio;
			writeln("Invalid number entered..");
			return;
		}
	}
	int number;
	number = 10;
	enum Light {OFF, ON}
	Light[] lights;
	lights.length = number;
	string line;
	int[] range;
	
	do {
		import std.process;
		system("clear");
		
		lights[] = Light.OFF;
		lights.length = number;
		range.length = 0;
		foreach(i; 0 .. number) {
			int nc; // number candidate
			do {
				import std.random;
				nc = cast(int)uniform(0, number);
			} while(lights[nc] == Light.ON); // lights on are done ones
		
			lights[nc] = Light.ON;
			import std.string;
			line ~= format("%s ", nc + 1);
			range ~= nc + 1;
			if (line.length > 3 * 10 || i == number - 1) {
				import std.stdio;
				writeln(line);
				line.length = 0;
			}
		}
	
		import std.stdio;
		import std.algorithm;
		writeln("Average: ", range.reduce!"a + b" / number);
		int[] range2;
		
		// make a copy
		import std.array;
		range
		.map!((a) { range2 ~= a; return a; } )
		.array;
		
		writeln("Sort: ", range2.sort!"a > b");
	
		void along() {
			write("  ");
			foreach(n; 0 .. number)
				write(n+1);
			writeln;
		}

		import std.range;
		import std.string;
		along;
		foreach(n; 0 .. number)
			writeln(format("%2s", n+1), ' '.repeat.take(range[n] - 1), '#', ' '.repeat.take(number - range[n]), format("%-2s", n + 1));
		along;
	
		import core.thread;
		Thread.sleep(frameTimeMsecs.msecs);
	} while(true);
}
