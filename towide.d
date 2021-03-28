//#why isn't it in the array?
/++
 + Converts tabs to dot gaps, or
 + 
 + the other way around, depending if the file has tabs or not
 + 
 + ---
 + wide src.d
 + notepad src.txt
 + wide src.txt
 + notepad src.txt
 + ---
 +/
module towide;

import std.stdio: File;
import std.string: indexOf;
import std.file: readText, read, fwrite = write;
import std.array: replace; //, indexOf; //#why isn't it in the array?
import std.path: setExtension;

void main( string[] args ) {
	auto fileName = args[ 1 ];
	auto content = readText( fileName );
	immutable notFound = -1;
	alias thisIs = indexOf;
	string gap = "....", tab = "\t";
	
	bool isFound( string haystack, string needle ) {
		if ( thisIs( haystack, needle ) == -1 )
			return false;
		return true;
	}
	
	if ( thisIs( content, tab ) == notFound )
		content = replace( content, gap, tab );
	else
		content = replace( content, tab, gap );
	

	fwrite( setExtension( fileName, "txt" ), content );
}
