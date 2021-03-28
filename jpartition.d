void main() {
	import std.range;
	import std.algorithm;

	auto arr = [2,4,5,7,5,3,4,2,6,7,5];
	
	auto a = arr.
		map!(a => !(a & 1)); //#result

	auto b = arr.
		partition!(a => !(a & 1)); //#doesn't do what I expected [[2,4,4,2,6][7,5,3,7,5]] or some thing (groupBy)

	auto c = arr; //.
//		groupBy!(a => !(a & 1));

	import std.stdio;
	writeln(a, '\n', b, '\n', c);
	
	assert([true, true, true, true, true, false, false, false, false, false, false] == a.array); // and it sorts them with arr
	assert([3, 5, 7, 5, 7, 5] == b);
}