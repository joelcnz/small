/**    
    Arthur: Joel Ezra Christensen
    Date: 26 Feb 2010
	upDate: 6 9 2017
	upDate: 22 11 2017
*/

import std.stdio: writeln, stdin, File;
import std.string: stripRight;
import core.thread: Thread, dur;

void main(string[] args) {
	File finput = stdin;
	string fileName = "";
	if (args.length == 2)
		fileName = args[1];
	
	import std.file: exists;
	
	if (fileName.exists) {
		finput = File(fileName, "r");
		writeln(`File input`);
	} else {
		writeln(`stdin (eg ./textscroll < journal.txt)`);
	}
	
   	 /// Main string holds all the data at once
   	 foreach(line; finput.byLine) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
   		 line.stripRight.writeln;
   		 Thread.sleep(100.dur!"msecs");
   	 }
}
