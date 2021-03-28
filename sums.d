import std.conv;
import std.file;
import std.stdio;
import std.random;
import std.range;
import core.time;
import std.stdio;
import std.string;

import jmisc.base;

void main(string[] args) {
	scope(exit) {
		writeln;
		writeln("###");
		writeln("#  ");
		writeln("###");
		writeln("  #");
		writeln("###");
		writeln;
	}
	
	if (args.length != 2) {
		writeln("You must include an accound name. Eg. `./sums Joel`");
		return;
	}
	string account = args[1] ~ "SumsHistory.txt";
	int a, sumsTableNumber;
	int[] arr = new int[12];

	append(account, upDateStatus("<-> Welcome to Sums"));

	int getSumsTableNumber(void delegate() dg, in string label = "") { // what times table number
		int result;
		bool done;
		do {
			try {
				write(label);
				stdout.flush;
				dg();
				result = readln.chomp.to!int;
				done = true;

			} catch(ConvException e) {
				writeln("Try again.");
				done = false;
			}

		} while(false == done);
		
		return result;
	}
	sumsTableNumber = getSumsTableNumber({}, "Enter main sums number, (-1 for random): ");
	append(account, upDateStatus("<-> " ~ (sumsTableNumber == -1 ? "Random" : text(sumsTableNumber, " sums")), ""));

	arr = iota(1, 12).array;
	arr.randomShuffle;
	
	int input;
	int rightCount;
	bool firstRound = true;

	MonoTime before = MonoTime.currTime(),
		after;
	Duration diff;
	
	string output = "";
	int mistakes = 0;

	int order = uniform(0,2);
	void swapOrder() {
		order = (order == 0 ? 1 : 0);
	}

	foreach(b; arr) {
		MonoTime ebefore = MonoTime.currTime;
		if (sumsTableNumber != -1)
			a = sumsTableNumber;
		else
			a = cast(int)uniform!"[]"(1, 12);

		void printExpression(in int a, in int b) {
			writef("%s + %s = ", a, b);
		}
		
		swapOrder;
			
		while(true) {
			input = getSumsTableNumber({
				(0 == order ? printExpression(a, b) : printExpression(b, a));
			});
		
			if (input == a + b) {
				string result = text("It Is! -- Right in: ", MonoTime.currTime - ebefore);
				output ~= format("%s + %s = %s\n", a, b, a + b) ~ result ~ "\n";
				writeln(result);
				break;
			} else {
				string result = format("%s + %s is not %s!", a, b, input) ~ " Try again..";
				output ~= result ~ "\n";
				writeln(result);
				mistakes += 1;
				swapOrder;
			}
		}
	}
	
	after = MonoTime.currTime();
	diff = after - before;
	
	append(account, output);
	append(account, upDateStatus(format("in Time: %s (%s mistake%s)", diff, mistakes, (mistakes == 1 ? "" : "s"))));
	writeln("See ", account);
}
