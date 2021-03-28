//#not work (and he got the job!)
//Org: http://www.codinghorror.com/blog/2007/02/why-cant-programmers-program.html
// swapping two varibles without using a temp variable
import std.stdio;

//import jeca.miscs;

void main() {
	int a = 3, b = 7;
	
//	mixin( trace( "/+ Before: +/ a", "/+ Before: +/ b" ) );
	
	void swap( ref int a, ref int b ) {
		a = b + a;
		b = a - b;
		a = a - b;
	}
	
	//#not work (and he got the job!)
	void swap2( ref int a, ref int b ) {
		a = a | b;
		b = a ^ b;
		a = a ^ b;
	}
	
	foreach( index, doSwap; [ &swap, &swap2 ] ) {
		doSwap( a, b );
		if ( index == 1 )
			writeln( "Fail:" );
//		mixin( trace( "/+  After: +/ a", "/+  After: +/ b" ) );
	}
}
