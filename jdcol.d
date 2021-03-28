import std.stdio;
import std.string;
import dcollections.LinkList;

void main( string[] args ) {
	string sentence = "I went to town on a sunny afternoon";

	if ( args.length > 1 )
		sentence = args[ 1 ];

	auto list = new LinkList!string;

	foreach( word; sentence.split )
		list ~= word;

	void print( string message, Iterator!string s ) {
		write( message ~ " [" );
		foreach( i; s )
			write( " ", i );
		writeln( " ]" );
	}

	print( "Here are a few words: ", list );
	auto ptr = list.sort!"a.tolower < tolower.b";//(
	//	(ref string a, ref string b) {
	//		return tolower( a ) < tolower( b );
	//} );
	print( "Indifferent order: ", list );
	writeln( list[] );
 }
 
