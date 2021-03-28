import std.datetime.stopwatch;

/**
auto allTimer = JTimer();
JTimer[] questionTimers;
questionTimers ~= JTimer();
jtimer[questionIndex].start;
writeln(jtimer.timeString);
*/

void main() {}

struct JTimer {
private:
	StopWatch _timer;
public:
	auto timeString() {
		import std.conv;
		auto totalMsecs = _timer.peek.msecs.to!int; //#not sure about the to!int
		//stop;
		auto seconds = totalMsecs / 1_000;
		auto leftOverMsecs = totalMsecs % 1_000;

		import std.string;
		
		return format(" %s.%03s seconds", seconds, leftOverMsecs);
	}
	
	void start() {
		_timer.reset;
		_timer.start;
	}
	
	void stop() {
		_timer.stop;
	}
	
	unittest {
		import std.stdio;

		StopWatch _timer;
		_timer.start;
		writeln("Press enter");
		readln;
		_timer.stop;
		writeln(_timer.peek.msecs);
		readln;
		writeln(_timer.peek.msecs);
	}
}

