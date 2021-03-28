//#not work
import std.stdio;

template functionNameOf (alias func)
{
    enum functionNameOf = (&func).stringof[2 .. $];
}

void hut() {
}

int seat( int a ) { return 1979; }

void fun1() {}
void fun2() {}

void main() {
	assert( (&hut).stringof[ 2 .. $ ] == "hut" );
	writeln( functionNameOf!( seat ) ); // prints seat
	writeln( (&seat).stringof );
	
	//#not work
	foreach( fname; [ &fun1, &fun2 ] )
		writeln( functionNameOf!( fname ) );
}
