auto filt(T)(bool function(T) dg, T[] arr) {
	import std.range: empty, popFront, front;
	T[] arr2;
	for(; ! arr.empty; arr.popFront)
		if (dg(arr.front))
			arr2 ~= arr.front;

	return arr2;
}

void main() {
	import std.stdio; writeln;
	import std.string: split;
	writeln(filt!string(a => a[0] == 'J', "Ria Joel Alan Timothy Mari Jeremy Joy Lahtrell".split));
}
