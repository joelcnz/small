//#palindrome
//#woops, it all disapears. ? - What a load of rubbish, good for nothing! (save it first!)
// Found at IDEone
// Have altered it my self, and added wrapper to it (got that from some one too).
import std.stdio;
import std.string;
import std.algorithm;
import std.range;

//#palindrome
bool palindrome(Range)(Range range) {
    for (; !range.empty; range.popFront(), range.empty || range.popBack())  
{
        if (range.front != range.back)
            return false;
    }
    return true;
}

class wrapper( T ) {
	int index;
    T[] data;
	
    bool empty()
	{
        //return data.length == 0;
		return index == -1 || index == data.length;
    }
	
    void popFront()
	{
       //data = data[1..$]; //#woops, it all disapears. ? - What a load of rubbish, good for nothing! (save it first!)
	   ++index;
    }
	
	void popBack()
	{
		//data = data[ 0 .. $ - 1 ];
		--index;
	}
	
    ref T front() {
        return data[ index ];
    }
	
	ref T back()
	{
		return data[ index ];
	}

/*	
	T[] dup()
	{
		return data.dup;
	}

	int print( int delegate(T) dg ) {
		auto dcopy = data.dup;
		int result;
		while ( ! empty ) {
			result = dg( front );
			popFront;
			if ( result )
				break;
		}
		data = dcopy;
		return result;
	}
*/
} 

void main(){
	auto w = new wrapper!string;

	w.data = split("paper sissors rock");
	/*
	w.print( (string e) {
			writeln(e);
			return 0;
		} );
	w.print( (string e) {
			writeln(e);
			return 0;
		} );
	*/
	writeln("foreach with ranges");
	/*
	foreach (thing; w.dup)
		writeln(thing);
	foreach_reverse (thing; w.dup)
		writeln(thing);

	writeln("Selection");
	foreach (thing; w.dup)
		writeln(thing);
	*/
	w.index = 0;
	foreach ( e; w )
	{
		writeln (e);
	}
	w.index = cast(int)w.data.length - 1;
	foreach_reverse ( e; w )
	{
		writeln (e);
	}
	
	// filter! - Number has to be 490 or greater
	// iota - starts number at 1, last number printed is 500 and steps +1 at a time
	foreach(v; iota(1,501,1).filter!("a >= 490")) {
		writeln(v);
	}
	/// backwards in 2 unit steps
	foreach(v; iota(500,490-1,-2)) {
		writeln(v);
	}
	// down to the wire
	foreach(v; iota(0,1+1,1)) {
		writeln(v);
	}
	
	sliceTest();
}

//Org: ng d.D Mafi 27 Aug 2011
import std.stdio, std.algorithm, std.range, std.conv, std.exception;

void sliceTest() {
	writeln( "Slice test:" );
    auto x = [0, 1, 2, 3, 4, 5];
    auto t = x.take(3);
    writeln( "(t):" );
    foreach(i, ref elem; t) {
        writefln("%s : %s (%s)", i, elem, &elem);
    }
    writeln( "array(t):" );
    foreach(i, ref elem; array(t)) {
        writefln("%s : %s (%s)", i, elem, &elem);
    }
    writeln( "slice(t) - new idea I think:" );
    foreach(i, ref elem; slice(t)) {
        writefln("%s : %s (%s)", i, elem, &elem);
    }
}

/**
Retuns a slices of the data the given range represents.

throws: ConvException if the data is not continous.
*/
ElementType!(R)[] slice(R)(R range) if(isInputRange!R) {
    alias ElementType!(R) E;
    E* addr = null;
    size_t length = 0;
    foreach(i, ref e; range) {
        static assert(is(typeof(e) == E));

        if(addr is null) {
            addr = &e;
        } else {
            enforce(&e is (addr + i), new ConvException("Could not create a continous slice."));
        }

        length++;
        assert(i == length-1);
    }
    if (addr is null) return null;
    else return addr[0.. length];
}
