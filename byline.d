//*altered the end '*'s 31 October 2014*
//#no strip, like the second one.
import std.stdio: writeln, File, lines;
import std.string: stripRight;

void main() {
	auto file = File( "byline.d", "r" );
	foreach( line; file.byLine ) {
		writeln( '*', line[0..$-1], '*' ); //#no having to put strip, not like the second one.
	}
	
	foreach( string line; lines( File( "byline.d", "r" ) ) ) {
		writeln( '/', stripRight( line ), '\\' );
	}
}
//#both don't do the last line if it's blank
