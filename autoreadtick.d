/**    
    Arthur: Joel Ezra Christensen
    Date: 26 Feb 2010
*/

version = TickOver;
version = AutoRead;

import std.stdio: writeln, write, stdin;
import std.string: stripRight, toStringz, split;
import core.thread: Thread, dur;

alias dur!"msecs" linePause;

void main() {
    version ( AutoRead ) {
		string[] strLines;

		import std.file;
		// Main string holds all the data at once
		string[] content;
		foreach(line; "I went for a walk and fell down a hole!".split)
			content ~= line.idup;
		foreach( string line; content ) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
			strLines ~= stripRight( line );
		}

		// Go round and round
		for( int i = 0; i < strLines.length; i++) {
			writeln( strLines[ i ] );
			Thread.sleep( 100.linePause);
		}
    }
    
    version ( TickOver ) {
   	 int msecs = 200,
   		 seconds;
   	 foreach( p; 0 .. 10 ) {
   		 if ( p < 5 ) {
   			 writeln( msecs, ") msecs" );
   			 Thread.sleep(msecs.dur!"msecs");
   			 msecs -= 30;
   		 }
   		 else {
   			 if ( p < 9 )
   				 Thread.sleep(1.dur!"seconds");
   			 writeln( seconds, ") seconds" );
   			 ++seconds;
   		 }
   	 }
    }
}
