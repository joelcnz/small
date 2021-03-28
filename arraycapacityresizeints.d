//#not work
import std.stdio, std.conv, std.string;

void main() {
	auto arr = [1,2,3];
	writeln( arr.capacity ); // 3
	arr ~= [4,5,6];
	writeln( arr.capacity ); // 7
	arr ~= [7,8,9];
	writeln( arr.capacity ); // 15
	//arr.capacity = 31; // error - arr.capacity is not an lvalue

	immutable resize =
	`	char[] a = "12".dup;
	a.length = 3;
	a[2] = '3';
	assert( a == "123" );`;
	writeln( resize );
	mixin( resize );
	
	int[] arr2;
	immutable arrints = "arr2 = to!(int[])( readln.strip.split );";
	bool fail;
	do {
		fail = false;
		try {
			writeln( arrints );
			mixin( arrints ); //#not read at compile time 
		} catch( Exception e ) {
			fail = true;
			writeln( "Try again.." );
		}
	} while( fail == true );
	int total = 0;
	foreach( number; arr2 )
		total += number;
	writeln( arr2, " Total: ", total );
}
