// out of http://www.digitalmars.com/d/2.0/phobos/std_algorithm.html#find
import std.stdio;
import std.algorithm;

void main() {
	auto arr = [ 1, 2, 3, 4, 1 ];
	assert(arr.find!"a > 2" == [ 3, 4, 1 ]);

	// with predicate alias
	bool pred(int x) { return x + 1 > 1.5; }
	assert(arr.find!(pred) == arr);
	
	writeln( find!( (int x) { return x > 2; } )( arr[ 0 .. $ - 1 ] ~ [ 5, 6, 7, 7, 5 ] ) );
	
	int x;
	writeln( arr = [ 1, 2, 6, 8, 3, 2, 5, 7, 2, 1 ] );
	filt( (int x) { return x > 2; }, arr );
	write( '\n' );
	filt( (int x) { return x < 4; }, arr );
	writeln;
}

void filt( bool delegate( int x ) theIf, int[] arr ) {
	write( '{' );
	scope( exit )
		write( '}' );
	foreach( i, e; arr ){
		if ( theIf( e ) )
			write( e, i < arr.length - 1 ? "; " : "" );
		else
			if ( i < arr.length - 1 )
				write( ";  " );
	}
}
