@property bool empty(T)(T[] a) { return a.length == 0; }
@property ref T front(T)( T[] a ) { return a[0]; }
void popFront(T)( ref T[] a) { a = a[1..$]; }

V reduce( alias fun, V, R )( V x, R range ) {
	for( ; !range.empty; range.popFront() )
		x = fun( x, range.front ); // eg. x = x + range.front;
	return x;
}

double average( double[] values... ) {
	assert( !values.empty );
	return reduce!( (a, b) { return a+b; } )( 0.0, values ) / values.length;
}

void main() {
	assert( average(1,2,3) == 2 );
}
