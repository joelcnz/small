//#I still don't get lazy
//#What's this?!
//#what's this `count` here
// From some one elses source file
// Hey come on, just get the whole army!
import std.algorithm: canFind, map,
  filter, sort, uniq, joiner, chunkBy, splitter;
import std.array: array, empty;
import std.range: zip, iota;
import std.stdio: writeln;
import std.string: format;
import std.ascii: digits, whitespace;

void main()
{
	/+
    string text = q{This tour will give you an
overview of this powerful and expressive systems
programming language which compiles directly
to efficient, *native* machine code.};
+/
	string text = `John 3:16 -- "For God so loved the world, that he gave his only Son,
		that whoever believes in him should not perish but have eternal life."`;
  //string text = "I went for a walk and fell down a hole.";

    // splitting predicate
    //alias pred = c => canFind(" ,.\n\t\":-" ~ digits, c);
    alias pred = c => (whitespace ~ `:-,."` ~ digits).canFind(c);
    // as a good algorithm it just works
    // lazily without allocating memory!
    auto words = text.splitter!pred
      .filter!(a => !a.empty);

    auto wordCharCounts = words
      .map!"a.count"; //#what's this `count` here
	
	import std.algorithm: each;
	import std.conv: text;
	
	zip(wordCharCounts, words)
		.array.sort!((a, b) => a < b).each!((a,b) => writeln(a + 1, ". ", b[1]));
	
	writeln;
    // Output the character count
    // per word in a nice way
    // beginning with least chars!
    zip(wordCharCounts, words)
      // convert to array for sorting
      .array()
      .sort()
      // we don't need duplication, right?
      .uniq()
      // put all in one row that have the
      // same char count. chunkBy helps
      // us here by generating ranges
      // of range that are chunked by the length
      .chunkBy!(a => a[0]) //#What's this?!
      // those elments will be joined
      // on one line
      .map!(chunk => format("%d -> %s",
          chunk[0],
          // just the words
          chunk[1]
            .map!(a => a[1])
            .joiner(", ")))
      // joiner joins, but lazily! //#I still don't get lazy
      // and now the lines with the line
      // feed
      .joiner("\n")
      // pipe to stdout
      .writeln();
}
