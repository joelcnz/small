/**
	Origin: The D programming language (page 8)
	Date: 5 Sep 2010
	Method: script < journal.txt > z.txt
*/
import std.stdio;
import std.string;
import std.algorithm;

void main() {
	writeln("Enter single words pur line (q - to quit):");
	ulong[string] dictionary;
	quit: foreach (line; stdin.byLine()) {
		// Break sentence into words
		// Add each word in the sentence to the vocabulary
		foreach (word; line.strip.splitter) {
			if (word in dictionary)
				continue;
			if (word.length > 0 && word[0] == 'q') {
				writeln("break out!");
				break quit;
			}
			auto newID = dictionary.length;
			dictionary[word.idup] = newID;
			writeln(newID, '\t', word);
		}
	}
}
