import std.stdio;

void main() {
	scope( exit )
		writeln( "End of main" );
	count( 4 );
}

void count( int num ) {
	writeln( num );
	scope( exit ) { writeln( "scope exit block called. id: ", num ); }
	if ( num == 0 )
		return;
	else
		count( --num );
}
