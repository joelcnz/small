//https://dlang.org/blog/2018/03/14/user-stories-funkwerk/
// I added cache

void main() {
	import std.algorithm : map, cache;
	import std.array : array;
	import std.range : tee;
	import std.stdio : writefln, writeln;
	import std.traits : isNumeric;
	
	auto square(T)(T a)
		if (isNumeric!T) {
			writefln("square value");
		return a*a;
	}

	[3, 5, 8]
	  .map!(a => square(a))
	  .cache()
	  .tee!(a => writeln(a))
	  .array;
}
