//Not work
void main() {
	// import std.datetime: datesInYear, byMonth, byWeek, formatWeek;
	import std;
	// import std.string: join;
	auto calender = daysInYear(2013)
		.byMonth().front // Janurary
		.byWeek()
		.formatWeek()
		.join(`\n`);
	
	import std.stdio: writeln;
	writeln(calender);
}