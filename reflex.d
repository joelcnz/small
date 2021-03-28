// also in a project on Mac OS (joelcnz/projects/JReflex)
module main;

string collection;

string output(in string str, bool write = false) {
	import std.stdio: writeln, jwrite = write;
	import std.file: append;

	if (! write) {
		writeln(str);
		collection ~= str ~ "\n";

		return str ~ "\n";
	} else {
		jwrite(str);
		collection ~= str;

		return str;
	}
}

void dumpBlock() {
	import std.stdio;
	import std.range;
	output("Go!");
}

void main() {
	import std.stdio;
	import std.random;
	import std.datetime;
	import core.thread;

	struct Record {
		int releaseTime; // msecs
		int record; // msecs
		bool valid; // false if disqualified

		string toString() const {
			import std.string;
			if (valid)
				return format("Pause: %4s, Record: %4s", releaseTime, record);
			else
				return format("Disqualification");
		}
	}
	Record[] recs;

	output("\nLets begin:");
	string button;
	while(button != "q") {
		auto rec = Record(0,0, true);
		rec.releaseTime = cast(int)uniform(500, 1_500);
		output("Wait for it: ", true); stdout.flush;
		Thread.sleep(rec.releaseTime.msecs);
		StopWatch sw;
		sw.reset;
		sw.start;
		dumpBlock;

		import std.string;
		button = readln.chomp;
		if (button == "q")
			break;

		sw.stop;
		import std.conv;
		rec.record = sw.peek.msecs.to!int;
		if (rec.record == 0)
			output("Disqualified! You jumped the gun!"),
			rec.valid = false;
		else
			output(rec.record.to!string);
		recs ~= rec;
	}

	output("\nResults:");
	foreach(item; recs) {
		output(item.toString);
	}

	import std.algorithm;
	output("\nAnd again in an order:");
	float avg = 0;
	foreach(item; recs.sort!"a.record < b.record") {
		output(item.toString);
	}
	
	foreach(item; recs)
		avg += item.record;
	
	import std.file;
	append("records.txt", collection);
	writeln("Average: ", avg / recs.length);
}
