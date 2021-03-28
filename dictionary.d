//Org: chap 1 page 8 D book
// eg. dictionary.exe < dictionary.d
//#a change
//# what's this?
// changed line to line.idup in once place so that it could compile,
// could've edited dic[ word ] and changed it to word.idup like it suggests in the errata

// Mainly lists the different fragments

import std.stdio, std.string;

void main() {
	ulong[ string ] dic;
	ulong[ string ] wordCnt;
	ulong numberOfWords;
	writeln("Enter text:");
	done: foreach( line; stdin.byLine ) { // in chars not string
		if (line.length > 0 && line[0] == 'q')
	 	  	break done;
		
		// Break sentence into words
		auto words = line.idup.strip.split; //#a change
		// Add each word in the sentence to the vocabulary
		foreach ( word; words ) {
				++wordCnt[ word ];
				numberOfWords++;
	        if ( word in dic )
				continue; // nothing to do //# what's this?
	        ulong newID = dic.length;
	        dic[ word ] = newID;
	        writeln( newID, '\t', word );
	   }
   }
	writeln( "\nNumber of times, and name." );
	foreach( key, value; wordCnt )
	   writeln(
	   value,
	   ' ',
	   key);
	writeln("total words: ", numberOfWords);
}
