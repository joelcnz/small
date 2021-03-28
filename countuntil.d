//#what does this do?
//#org: got it from github phobos, removed the string handling part
import std.stdio: writeln;
import std.string: newline;
import std.algorithm: countUntil;
import std.array: array, iota, save;

class A {
	int n;
	this( int n ) {
		this.n = n;
	}
}

void main() {
	assert(countUntil([1,2,3,4,5,6], [4,5] ) == 3);
	//                           /-----b-----\  \a/ - a is the main article
	writeln( countUntil!"a > b"([0,1,2,3,4,5,6], 4 ), newline );
	
	A[] arr;
	foreach( i; iota( 5, 0, -1 ) ) {
		writeln( i );
		arr ~= new A( i );
	}
	
	auto arr2 = array( arr ); //#what does this do?
	
/+
	assert(countUntil("hello world", "world") == 6);
	assert(countUntil("hello world", 'r') == 8);
	assert(countUntil("hello world", "programming") == -1);
	assert(countUntil([0, 7, 12, 22, 9], [12, 22]) == 2);
	assert(countUntil([0, 7, 12, 22, 9], 9) == 4);
	assert(countUntil!"a > b"([0, 7, 12, 22, 9], 20) == 3);
+/
}

version( none ) {
	sizediff_t countUntil(alias pred = "a == b", R, N)(R haystack, N needle) 
		if (is(typeof(startsWith!pred(haystack, needle))))
	{
		typeof(return) result;
		for (; !haystack.empty; ++result, haystack.popFront())
		{
			if (startsWith!pred(haystack, needle)) return result;
		}
		return -1;
	}
}
