import std.stdio;
import std.algorithm;

void main() {
	/+
	// swift
	var sortedStrings = sorted(stringArray) {
	$0.uppercaseString < $1.uppercaseString
	}
	+/
	
	import std.string;
	auto stringArray = "cat dog house rock BOX wheel".split;
	auto jjoin = stringArray.join;
	writeln(jjoin, " ", typeid(jjoin));
	auto sortedStrings = stringArray
						 .sort!"a.toUpper < b.toUpper"; //, SwapStrategy.stable);
	writeln(sortedStrings.join);
	
	//Doc
	// Showcase stable sorting
	string[] words = [ "aBc", "a", "abc", "b", "ABC", "c" ];
	sort!("toUpper(a) < toUpper(b)", SwapStrategy.stable)(words);
	assert(words == [ "a", "aBc", "abc", "ABC", "b", "c" ]);
}