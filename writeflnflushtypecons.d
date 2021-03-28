// crashes when you use no window
import std.stdio;
import std.string;
import std.typecons;

void main() {
	auto f = File( "z.txt", "w" );
	scope( exit )
		f.close;
	string foo = "bar";
	foreach( n; 0 .. 10 ) {
		writefln( "%s", foo );
		f.write( format( "count duck-u-lar: %s\n", n ) );
	}
	
	// also
	write( "Using flush" );
	stdout.flush;
	
	void display(T...)( T args ) {
		writeln( tuple( args ).expand );
	}
	
	display( "I went ", 4, " a walk, and fe", 11, " down a hole!" );
}
