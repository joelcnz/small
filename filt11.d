

void main() {
	auto arr = [1,9,-6,2,8,3,-2,7,4,6,5,-4];
	import std.stdio: writeln;
	writeln(filt!int(a => a < 0, arr));
	
	auto arr2 = "Joel 35 Alan 38 Timothy 32 Ria 41 Joy 59 Jeremy 21 Mari 12 Lahtrell 4 Neville 68".split;
	import std.range: empty, popFront, front;
	while(! arr2.empty) {
		arr3 ~= arr2.front;
		arr2.popFront;
		arr3 ~= arr2.front;
		arr2.popFront;
	}
	
	writeln(filt!string)
}

auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront) {
		if (dg(arr.front) == true)
			arr2 ~= arr.front;
	}
	return arr2;
}
