//#not work!
void main() {
	import std.stdio;
	import std.range;
//	auto inLines = readln.byLine; //#not work!
	auto inLines = readln.split("\n");
	import std.conv;
	immutable thisNumber = inLines.front.to!int;
	inLines.popFront;
}