/// 226 Feb 2011
import std.stdio: writeln;
import std.string;
import std.conv;
//import std.complex;

version = String;

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

	string toString() { return values.to!string; }
}

void main() {
    Range!int list;
    list.add(1, 2, 3);
    writeln( list ); // same as putting: writeln(list.toString());
    
    version(Char) {
	    Range!char forwards, backwards;
		forwards.add( "House in the paddock".dup );
	}
	version(String) {
	    Range!string forwards, backwards;
		forwards.add( "House in the paddock".split );
	}
    backwards = forwards;
    foreach( word; forwards ) {
		writeln( word );
	}
    foreach_reverse( word; backwards ) {
		writeln( word );
	}
	
//	writeln( toString( "%s %.2f %d", "One", 0.2, 3) ); //#not work
}
