void main() {
	import std.stdio;
	import std.datetime;
	
	Duration gap = 4.weeks;
	
	auto timeNow = cast(DateTime)Clock.currTime;
	Date myBirthday;
	with(timeNow)
		myBirthday = Date(year + (Date(year, month, day) > Date(year, 4, 30) ? 1 : 0), 04, 30);
	//Date myBirthday = Date(timeNow.year + (Date(timeNow.year, timeNow.month, timeNow.day).diffMonths(Date(timeNow.year, 4, 30) < 1;
	writeln("My birthday:");
	writeln(myBirthday);
	writeln("Dad's birthday, using my birthday month and day");
	writeln(myBirthday + gap);

	Date dateOfBirth = Date(1979, 4, 30);
	writeln;
	with(timeNow)
		writeln("I'm ", (timeNow.date - dateOfBirth), " old.");
	
	import std.string;
	import std.conv;
	bool right;
	int[3] inputDate;
	do {
		right = true;
		try {
			write("Enter future date (eg `1979 4 30`): "); stdout.flush; inputDate = readln.split.to!(int[3]);
		} catch(ConvException e) {
			writeln("Some error, try again..");
			right = false;
		}
	} while(! right);
	auto date = Date(inputDate[0], inputDate[1], inputDate[2]);
	writeln((date - timeNow.date), " till ", date);
}
