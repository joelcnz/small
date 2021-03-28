// This test program for Jyble (whole word(s) search) is working!
import std.stdio;
import std.string;
import std.ascii;

void main() {
	auto words = "man well".split;
	auto ver = "man wella";
	
	writeln([ver]);
	
	foreach(word; words) { // go through each word checking, possibly checking if they are whole words that are found
		writeln(word);
		size_t p = ver.indexOf(word);
		bool noLeftLetter = (p == 0 || ! ver[p - 1].inPattern(lowercase));
		bool noRightLetter = (p + word.length == ver.length || (p + word.length < ver.length && ! ver[p + word.length].inPattern(lowercase)));
		
		if (noLeftLetter && noRightLetter) {
			writeln("pass");
		} else {
			writeln("fail");
		}
	} // foreach
}