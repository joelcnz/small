//#TDPL 111 4.3
// needs more work
version = Book;

import std.stdio;

void main() {
	int[ /+  width: +/ 3 ][ /+ height: +/ 2 ] arr;
	arr[ /+ y: +/ 2 - 1 ][ /+ x: +/ 3 - 1 ] = 4; // bottom right arr[ 0 .. 2 ][ 0 .. 3] or arr[ 0 - 1 ][ 0 - 2 ]
	
	Futs[][]
		arr2 = [ [ /+ [0][0]: +/ Futs( "Timothy" ), /+ [0][1] +/ Futs( "Hamish" ) ],
				 [ /+ [1][0] +/ Futs( "Ryan" ), /+ [1][1] +/ Futs("Jeremy") ],
				 [ /+ [2][0]: +/ Futs("Mari"), /+ [2][1]: +/ Futs("Lahtrell") ] ];

	arr2[0][0].hello; /* Timothy */ arr2[0][1].hello; /* Hamish */
	arr2[1][0].hello; /* Ryan */    arr2[1][1].hello; /* Jeremy */
	arr2[2][0].hello; /* Mari */    arr2[2][1].hello; /* Lahtrell */

	char[][] arr3;
	arr3.length = 3;
	foreach(y; 0 .. 3)
		arr3[y].length = 2;
	arr3[2][1] = 'x'; // y, x
	
/+
Futs -> ##
		|| /-Ryan
		|| |/-Jeremy
		|| ||
	    |\-##
	    |
		\-##
		  ||
		  |\-Hamish
		  \-Timothy
 +/

version( Book ) {
	//#TDPL 111 4.3
	auto array = new double[][5]; // Array of five arrays of double
								  // 	each initially null (Joel: or is it nan)
	
	// Make a triangular matrix
	foreach( i, ref e; array ) {
		e = new double[ array.length - i ];
	}

	// ref is faster
	foreach( ref row; array ) {
		foreach( ref column; row )
			write( '#' );
		writeln();
	}
} // book end
}

struct Futs {
	private string name;

	this( string name ) {
		this.name = name;
	}
	
	void hello() {
		writeln( "Hello " ~ name ~ '!' );
	}
}
