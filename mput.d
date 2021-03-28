import std.stdio;
import std.string;
import std.random; // uniform(0,10);
import std.conv; //i=parse!int
import std.datetime;

void main() {
	int[2] variables;
	string input;
	writeln("Enter 'quit' to exit");

	int rand() {
		return uniform(0, 100);
	}

	auto getSecondsStr(in long time) {
		import std.conv : text;
		return text(time / 1000, ".", time % 1000);
	}

	StopWatch sw;
	struct Time {
		TickDuration time;
		int a, b;
	}
	Time[] times;
	while(true) {
		foreach (ref v; variables)
			v = rand();
		int answer, guess;
		answer = variables[0] + variables[1];
		sw.reset;
		sw.start;
		do {
			write(variables[0], "+", variables[1], "=");
			input = readln().strip;
			if (input != "" && input[0] == 'q')
				goto quit;
			if (isAValidNumber(input) == false) {
				writeln("Try, try, try again!");
				continue;
			}
			guess=parse!int(input); // User input
			if (guess == answer) {
				sw.stop;
				times ~= Time(sw.peek, variables[0], variables[1]);
				writeln("You're right! - in seconds ", getSecondsStr(times[$ - 1].time.msecs));
			}
			else
				writeln(guess < answer ? "higher" : "lower");
		} while (guess != answer);
	} //for
		
quit:
	TickDuration total;
	long[] forAve;
	foreach(t; times) {
		writefln("%s+%s=%s in %s seconds", t.a, t.b, t.a + t.b, getSecondsStr(t.time.msecs));
		total += t.time;
		forAve ~= t.time.msecs;
	}
	import std.algorithm;
	writefln("Average time: %s", getSecondsStr(reduce!((a, b) => a + b)(cast(long)0, forAve) / times.length));
	writefln("Total time: %s", getSecondsStr(total.msecs));
	
	writeln("Ok then, see you later, do call again! :-)");
}

bool isAValidNumber(string testNumber) {
	if (testNumber.length == 0)
		return false;
	foreach (chr; testNumber)
		if (chr < '0' || chr > '9')
			return false;
	return true;
}
