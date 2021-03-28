//Org: Got out of std.datetime
import std.stdio;
import std.datetime;

void main() {
				import std.datetime;
			
			auto currentTime = Clock.currTime();
			//auto timeString = currentTime.toISOExtString();
			auto timeString = currentTime.toSimpleString;
	writeln(timeString);
	return;


	auto d = TimeOfDay(15, 1, 2) - TimeOfDay(12, 0, 0);
	long hours = d.hours;
	long minutes = d.minutes;
	long seconds = d.seconds;
	writefln("%s %s %s", hours, minutes, seconds);
	writeln(d.toString());
	
	auto duration = TimeOfDay( 13, 10 ) - TimeOfDay( 1, 3 );
	writeln( duration );
	assert( duration.toString == "12 hours and 7 minutes" );
	assert( duration == 12.dur!"hours" + 7.dur!"minutes");

	auto st1 = SysTime(DateTime(2010, 1, 1, 12, 30, 33));
	st1.add!"months"(11);
	assert(st1 == SysTime(DateTime(2010, 12, 1, 12, 30, 33)));

	auto st2 = SysTime(DateTime(2010, 1, 1, 12, 30, 33));
	st2.add!"months"(-11);
	assert(st2 == SysTime(DateTime(2009, 2, 1, 12, 30, 33)));

	auto st3 = SysTime(DateTime(2000, 2, 29, 12, 30, 33));
	st3.add!"years"(1);
	assert(st3 == SysTime(DateTime(2001, 3, 1, 12, 30, 33)));

	auto st4 = SysTime(DateTime(2000, 2, 29, 12, 30, 33));
	st4.add!"years"(1, AllowDayOverflow.no);
	assert(st4 == SysTime(DateTime(2001, 2, 28, 12, 30, 33)));

	auto st5 = SysTime( DateTime( 2011, 6, 7, 23, 30, 0 ) );
	st5.roll!"minutes"( 30 );
	assert( st5 == SysTime( DateTime( 2011, 6, 7, 23, 0, 0 ) ) );
}
