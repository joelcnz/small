import std.stdio;

void main() {
	int[] x = [1, 3, 5], y = [5, -6, 2];
	x[] = x[] + y[]; // or x[] += y[];
	test( x, [ 6, -3, 7 ] );
	++x[];
	test( x, [7, -2, 8]);
	x[] = y[] + 1;
	test( x, [ 6, -5, 3 ] );
} 

void test( int[] x, int[] y ) {
	assert( x == y );
	writeln( x, " - ", y, " - pass" );
}
