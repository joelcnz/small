
int[] arr(int[] a, int b) {
	return a ~ b;
}

T[] garr(T)(T[] arr, T x) {
	return arr ~ x;
}

import std.algorithm;
import std.stdio;
float sum(float[] f...) {
	write(f, " - ");
//	return reduce!((a, b) { return  a + b; })(0f, f);
	return reduce!((a, b) => a + b)(0f, f);
}

import std.stdio;
import std.array;
void main() {
	import std.range;
	foreach(c; 0 .. 3) {
		// show numbers from 1 to 9 plus 0 in a row
		reduce!((a, b) { write(b); return b; })(0, array(iota(1, 10, 1))~0);
	}
	writeln();
	writeln(1uL.max); //#note cast(ulong)1.min gives the max number
	writeln(1.min, " 0 ", 1.max);
	writeln([1,2,3].arr(4));
	writeln(arr([1,2,3],4));
	writeln(("one two three".split).garr("four"));
	writeln(sum(1,2,3,4));
}
