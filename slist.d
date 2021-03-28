//#(6 and 7)
//#failings, how do you loop through the list, can't even get the length of the list
// Org: learn.d 15 May 2011

/+
import std.container;
import std.stdio;
import std.algorithm;
import std.range;

void main()
{
    auto l = SList!int(1, 2, 3, 4, 5, 6, 7);

	writeln(l[]);
	
    auto a = find(l[], 2);      // Search for 2 ...
    l.linearRemove(take(a, 1)); // ... and remove just 2

	writeln(l[]);

    auto b = find(l[], 6);      // Search for 6 ...
    l.linearRemove(b);          // ... and remove from there //#(6 and 7)

	writeln(l[]);
	
	l.linearRemove(take(find(l[], 4), 1));

	writeln(l[]);

    assert(l == SList!int(1, 3, 5));
}
+/

version(all) {
import std.stdio: writeln, write, stdout;
import std.algorithm: find;
import std.range: take, array;
import std.container: SList;
import std.string: split;

void main( string[] args ) {
	string[] list; 
	if ( args.length == 1 )
		list = "My elements in the house are mine".split;
	else
		list = args[ 1 ].split;
    auto slist = SList!string( list );
    @property void print() {
		writeln( slist[] );
	}
    print;
    auto toRemove = find( slist[], "house" );
    slist.linearRemove( take( toRemove, 1 ) );
    print;
    slist.linearRemove( take( find( slist[], "elements" ), 1 ) );
    print;
    
    //#failings, how do you loop through the list, can't even get the length of the list
    write( "-<[" );
	writeln( "]>-" );
	auto tmp = array(slist[]);
    foreach( i, e; tmp) {
		write( e ); if ( i + 1 < tmp.length ) write( ' ' );
	}
}
} // version
