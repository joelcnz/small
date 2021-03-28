import jmisc;

void main(string[] args) in (args.length == 2) {
	import std.stdio;
	import std.string;
	import std.random;
	import std.conv;
	import std.algorithm;
	import std.range;
	import std.file;
	
	scope(exit) {
		writeln;
		writeln("###");
		writeln(" # ");
		writeln(" # ");
		writeln(" # ");
		writeln(" # ");
		writeln;
	}
	
	if (args.length == 1) {
		writeln("You must enter a title eg. './tables Joel'");
		return;
	}
	string account = args[1] ~ "TablesHistory.txt";
	append(account, upDateStatus("<-> Welcome to Tables"));
	
	class TimesTable {
		int x, y, answer;
		bool correct = true;
		
		this(int x, int y) {
			this.x = x;
			this.y = y;
			if (uniform(0, 2))
				swap(this.x, this.y);
			answer = x * y;
		}
		
		auto equation() {
			return format("%s x %s = ", x, y);
		}
		
		override string toString() {
			return format("%s x %s = %s", x, y, answer);
		}
	}
	
	TimesTable[] tt;
	
	auto getInput(in string header) {
		int num;
		bool cont = true;
		do {
			cont = true;
			try {
				write(header); stdout.flush; num = readln.chomp.to!int;
			} catch(Exception e)
				cont = false;

			if (! cont)
				writeln("Invalid number, try again!");
		} while(! cont);
		
		return num;
	}
	
	int tableNum = getInput("Enter times table number: ");
	
	foreach(e; iota(1,12 + 1))
		tt ~= new TimesTable(e, tableNum.to!int);
	tt.randomShuffle;
	
	int answer = 0;
	import core.time;

	string output;
	auto totalTimeStart = MonoTime.currTime();
	foreach(current; tt) {
		auto eachStartTime = MonoTime.currTime();

		bool cont = true;
		do {
			answer = getInput(current.equation);
		
			if (answer != current.answer) {
				string s = "That is incorrect, have another go..";
				output ~= text(current.equation, answer, "\n", s, "\n");
				s.writeln;
				current.correct = false;
				cont = false;
			} else {
				string s = text("It Is! - In ", MonoTime.currTime() - eachStartTime, " time.");
				output ~= text(current, "\n", s, "\n");
				s.writeln;
				cont = true;
			}
		} while(! cont);
	}
	append(account, output);
	append(account, upDateStatus("Hurray!\n", tt.count!(c => c.correct), "/12 Corrects (1st trys)!"));
	append(account, upDateStatus("Eclipsed Time: ", MonoTime.currTime() - totalTimeStart));
	writeln("See ", account);
}
