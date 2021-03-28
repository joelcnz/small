//#not work, how do I aviod mixin strings here?
/// And it works! :-D
import std.stdio;
import std.range;

void main()
{
	auto fib = recurrence!("a[n-1] + a[n-2]")(1, 1);
	
	foreach(e; take(fib, 10)) // <- prints first ten numbers from the sequence
	{ 
		writeln(e); 
	}
	
	writeln;
	writeln( "Or (have to look at the code to see):" );
	foreach(e; recurrence!"a[n - 1] + a[n - 2]"(1, 1).take(10) )
//	foreach(e; recurrence!((a) => a[ n - 1 ] + a[ n - 2 ])(1, 1).take(10)) //#not work, how do I aviod mixin strings here?
		writeln(e);
}

