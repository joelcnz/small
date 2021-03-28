import std.stdio;
import std.range: replicate;

// with eg. "#".repeat( 4 ), it only works at the module level, (eg. not nested in a class etc. or function)
//static 
static string repeat( string s, int count ) {
	auto result = "";
	foreach( i; 0 .. count )
		result ~= s;
	return result;
}

void main() {

	writeln( "#".repeat( 4 ) );
	writeln( "32RA ".repeat( 32 ) );
	writeln( "EZRA" );
	
	auto str = " ".replicate( 4 );
	assert( str == "    " );
}
