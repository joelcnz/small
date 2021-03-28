// ,-10,000,000
// -1,000
// ,-12,345,678
void main() {
	import std.stdio;
	foreach(num; [-10_000_000, -1_000, -12_345_678])
		formatNumWithCommas(num).writeln;
}

string formatNumWithCommas(in int num) {
	//https://dlang.org/changelog/2.082.0.html#std-algorithm-iteration-joiner
	import std.algorithm; //.comparison : equal;
	import std.range : chain, cycle, iota, only, retro, take, zip;
	import std.format : format;
	import std.conv: to;

	immutable number = num.to!string;
	static immutable delimiter = ",";
	
	return number.retro
	    .zip(3.iota.cycle.take(number.length))
	    .map!(z => chain(z[0].only, z[1] == 2 ? delimiter : null))
	    .joiner
	    .retro
		.to!string; // "12,345,678"
}
