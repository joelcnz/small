/+
 + All these people that go around making snap decisions. You'd think they had all these thin sticks.
 + 
 + All teshe ppeloe taht go aruond mkaing sanp dsenioics. Yu'od think tehy had all tshee tihn sitcks!
 +/
//pragma( lib, "libjeca" );

import std.stdio;
import std.array;
import std.random;
import std.range;
import std.ascii;
//import jeca.misc;
import jmisc;

void main(string[] args) {
	string result;
	auto words=args[1 .. $]; //getTextClipBoard().split;
	foreach(i, word; words)
		result~=jm_jumbleWord(word)~(i<words.length-1 ? " " : "");
	//setTextClipboard(result);
	writeln(result);
}
