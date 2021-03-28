// based on TDPL pages 275 - 276
import
	std.stdio,
	std.algorithm,
	std.conv;

void main() {
	enum OddWord {house, rat, cat};
	writeln( OddWord.cat );
	auto w = OddWord.rat;
	writeln( w.toString );
	
	enum NotWord {asgs, adsg, sdf};
	auto nw = NotWord.asgs;
	
	try {
		writeln( w );
		writeln( nw );
	} catch ( Exception e ) {
		writeln( "Error using enum: ", e.toString );
	}
	
	auto arr = __traits( allMembers, OddWord );
	foreach( i, s; arr ) {
		write( s, ( i < arr.length - 1 ? ", " : "" ) );
	}
	writeln( "\n", typeid( typeof( arr ) ) );
}

string toString(E)(E value) if ( is( E == enum ) ) {
	writeln("toString(E..");
	foreach( s; __traits( allMembers, E ) ) {
		if ( value == mixin( "E." ~ s ) ) return s;
	}
	throw new Exception( "enum value not found" ); //#how do you get this error?
}
