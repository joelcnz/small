/// 226 Feb 2011
import std.stdio: writeln, writefln;
import std.string;
import std.conv;
import std.complex;

struct Range(T) {
	T[] values;

	bool empty() { return values.length == 0; }
	void popFront() { values = values[ 1 .. $ ]; }
	void popBack() { values = values[ 0 .. $ - 1 ]; }
	ref T front() { return values[ 0 ]; }
	ref T back() { return values[ $ - 1 ]; }
	
	void add(T[] newValues...) {
	   values ~= newValues;
	}

	string toString() { return to!string( values ); }
}

void main() {
    Range!int list;
    list.add(1, 2, 3);
    writeln( list ); // same as putting: writeln(list.toString());
    
    Range!string forwards, backwards;
    forwards.add( split( "House in the paddock" ) );
    backwards = forwards;
    foreach( word; forwards ) {
		writeln( word );
	}
    foreach_reverse( word; backwards ) {
		writeln( word );
	}
	
	writefln("%s %.2f %d", "One", 0.2, 3);
}
