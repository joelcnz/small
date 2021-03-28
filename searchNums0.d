// Note the use of swap. Wed 21 Sep 2016
// this version doesn't work with only 2 items (always has the same result)

void main(string[] args) {
	ulong test = 20;
	if (args.length == 2) {
		import std.stdio : writeln;
		try {
			import std.conv : to;
			test = args[1].to!ulong;
		} catch(Exception e) {			
			writeln("Fatal error: Invalid input!");
			return;
		}
		
		if (test < 3) {
			writeln("Too lower number of items!");
			return;
		}
		
		if (test >= int.max) {
			writeln("Too bigger number!");
			return;
		}
	}
	int length = cast(int)test;
	import std.range : iota;
	import std.array : array;
	auto items = iota(1, length + 1, 1).array;
	foreach(_; 0 .. length) { //#maybe put foreach(ref _; items) - ref for speed
		import std.algorithm : swap;
		import std.random : uniform;
		size_t a, b;
		do {
			int rnd() { return uniform(0, length); }
			a = rnd;
			b = rnd;
		} while(a == b);
		swap(items[a], items[b]);
	}
	import std.stdio : writeln;
	writeln(items);
}
