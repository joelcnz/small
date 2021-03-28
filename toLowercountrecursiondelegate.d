// Org: 5 Sep 2011 Ryan's Mac Lap

import std.stdio: writeln, readln, File;
import std.string: toLower;
import std.array: replace;
import std.algorithm: count;
import std.ascii: cToLower = toLower;

alias writeln wl;

void main( string[] args ) {
	string str;
	if (args.length != 1)
		foreach(i, word; args[1 .. $ ])
			str ~= word ~ (i != args.length - 1 ? " " : "");
	else
		str = "I went for a walk and fell down a hole.";
	void print(string prefix = "") {
		wl( "prefix: ", str );
	}
 
	ubyte sumLetters(string str) {
		ubyte total = 0;
		foreach( dchar l; str ) {
			l = cToLower( l );
			if ( l >= 'a' && l <= 'z' )
				total += l - 'a' + 1;
		}

		return total;
	}
	
	wl(str, " - ", sumLetters(str));

	auto f = File("abc123.txt", "a");
	string input;
	while(input != "exit\n" && input != "q\n") {
		input = readln;
		if (input != "q\n")
			wl( input[0 .. $ - 1], " - ", sumLetters(input)),
			f.writeln(input[0 .. $ - 1], " - ", sumLetters(input));
	}
	f.close;

 print;
 str = reduceSpaces(str);
 print;

// wl( "Count the vowels then Press enter" );
// readln;

	auto vowels =
	  count!"a == 'u' || a == 'i' || a == 'a' || a == 'e' || a == 'o'"(toLower(str));
	wl("Number of vowels in sentence: ", vowels);

	import std.algorithm: canFind;
	import std.conv: to;

	immutable countFun = q{
		vowels = str.count!(a => "aeiou".canFind(a.toLower));
	};
	mixin(countFun);
	wl(countFun ~ ` Number of vowels in sentence: `, vowels);
}

string reduceSpaces(string str) {
	string last = str;

	str = replace(str, "  ", " ");

	if (str != last)
		return reduceSpaces(str);

	return str;
}
