void main() {
	import std.stdio: writeln, readln;
	import std.conv: to;
	import std.string: split;

	writeln("Enter a sentence with more than one space each gap:");
	auto userInput = readln[0 .. $ - 1].to!(wchar[]);
	writeln(userInput.squeeze(" ".to!(wchar[])));
}

import std.traits: isSomeString;

auto squeeze(S)(S str, S pat)
if (isSomeString!S) {
	import std.string: replace;

	S last, result = str, dpat = pat ~ pat;
	do {
		last = result;
		result = result.replace(dpat, pat);
	} while(result != last);
	
	return result;
}