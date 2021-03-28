//donkey! 6 9 2016
module stats;

import std.stdio, std.exception; //, std.contracts; - old

interface Stat {
	string toString();
}

abstract class Maths {
	float a, b;
}

class Add : Maths, Stat {
	override string toString() {
		import std.format;
		return format("%s + %s = %s", a, b, a + b);
	}
}

class Minus : Maths, Stat {
	override string toString() {
		import std.format;
		return format("%s - %s = %s", a, b, a - b);
	}
}

void main( string[] args ) {
	import std.string : split;
	args = "Add Minus".split;
	
	Stat[] stats;
	foreach( arg; args) {
		auto newStat = cast( Stat )Object.factory( "stats." ~ arg );
		enforce( newStat, "Invalid statistic function: " ~ arg );
		stats ~= newStat;
	}
/+
	with(stats[0])
		a = 3,
		b = 4;
	
	with(stats[1])
		a = 10,
		b = 3;
+/
//	for( double x; readf( " %s ", &x ) == 1; ) {
		foreach( s; stats ) {
			writeln(s);
//			writeln( "=>", x );
		}
//	}
}
