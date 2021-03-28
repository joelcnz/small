import std.stdio;

void main() {
	writeln(getDateTimeString);
	
	print("Sunday Monday Tuesday Wednesday Thursday Friday Saturday");
	print("January Feburary March April May June July August September October November December");
	monthLengths;
}

void print(in string names) {
	import std.string;

	foreach(name; names.split)
		writeln(name);
	writeln;
}

void monthLengths() {
	import std.datetime : DateTime, Clock;
	import std.string;
	
	DateTime dateTime = cast(DateTime)Clock.currTime();
	with(dateTime) {
		writeln(year);
		auto numMonths = [31,29,31,30,31,30,31,31,30,31,30,31];
		auto nameMonths = "January Feburary March April May June July August September October November December".split;
		struct Jonth {
			string nameOfMonth;
			int numOfMonthDays;
			
			string toString() const {
				return format("%s %s",numOfMonthDays , nameOfMonth);
			}
		}
		immutable numOfMonths = 12;
		Jonth[numOfMonths] jonths;
		foreach(i; 0 .. numOfMonths)
			jonths[i] = Jonth(nameMonths[i], numMonths[i]);
		foreach(const month; jonths)
			writeln(month);
	}
}

auto getDateTimeString() {
	import std.string : format, split;
	import std.datetime : DateTime, Clock;
	
	DateTime dateTime = cast(DateTime)Clock.currTime();
	with(dateTime) {
		return format(
			"%s " // day of the week (eg. 'Saturday')
			"%s %s %s " // date, month, year
			"[%s:%02s:%02s%s]", // hour:minute:second am/pm
			"Sunday Monday Tuesday Wednesday Thursday Friday Saturday".split[dayOfWeek],
			day, "January Feburary March April May June July August September October November December".split[cast(int)month - 1], year,
			hour == 0 || hour == 12 ? 12 : hour % 12, minute, second, hour <= 11 ? "am" : "pm");
	}
}
