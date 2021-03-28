//Org: TDPL book - page 153
import std.algorithm;
import std.string: split;

version( all ) {
	auto finder(T)(T x)	if (is(typeof(x == x) == bool)) {
		return (T[] a) { return find(a, x); };
	}
}

version( none ) {
	T[] delegate(T[]) finder(T)(T x)
		if (is(typeof(x == x) == bool))
	{
		return delegate(T[] a) { return find(a, x); };
	}
}

void main() {
	auto d = finder(5);
	assert(d([1, 3, 5, 7, 9]) == [ 5, 7, 9 ]);
	d = finder(10);
	assert(d([1, 3, 5, 7, 9]) == []);
	
	auto list = finder( "key" );
	assert( list( "a house key in the door".split ) == "key in the door".split );

	list = finder( "knob" );
	assert( list( "a house key in the door".split ) == [] );
}
