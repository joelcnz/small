void main() {
	import std.stdio : writeln;
	import std.conv : to;
	import std.range : zip;

	int[] a = [ 1, 2, 3 ];
	string[] b = [ "a", "b", "c" ];
	string[] result;

	foreach (tup; zip(a, b))
	{
	    result ~= tup[0].to!string ~ tup[1];
	}

	writeln(result); // ["1a", "2b", "3c"]

	size_t idx = 0;
	// unpacking tuple elements with foreach
	foreach (e1, e2; zip(a, b))
	{
	    writeln(e1); // a[idx]
	    writeln(e2); // b[idx]
	    ++idx;
	}
}
