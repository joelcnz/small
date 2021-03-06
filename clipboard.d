// the get and set functions (also the extern) are in the Jeca library
import std.stdio;
import core.stdc.string;
import std.string;
import std.conv;
import std.random;

extern(Windows) {
   bool OpenClipboard(void*);
   void* GetClipboardData(uint);
   void* SetClipboardData(uint, void*);
   bool EmptyClipboard();
   bool CloseClipboard();
   void* GlobalAlloc(uint, size_t);
   void* GlobalLock(void*);
   bool GlobalUnlock(void*);
}

string getTextClipBoard() {
   if (OpenClipboard(null)) {
	   scope( exit ) CloseClipboard();
       auto cstr = cast(char*)GetClipboardData( 1 );
       if(cstr)
           return cstr[0..strlen(cstr)].idup;
	}
	return null;
}

string setTextClipboard( string mystr ) {
	if (OpenClipboard(null)) {
		scope( exit ) CloseClipboard();
		EmptyClipboard();
		void* handle = GlobalAlloc(2, mystr.length + 1);
		void* ptr = GlobalLock(handle);
		memcpy(ptr, toStringz(mystr), mystr.length + 1);
		GlobalUnlock(handle);

		SetClipboardData( 1, handle);
	}
	return mystr;
}

void main() {
	writeln( "What's on the board Miss Fored(sp)? ", getTextClipBoard() );
	setTextClipboard( "Here's a word - " ~ "goat rock tree beach pinecone table bus".split[ uniform( 0, 7 ) ] );
	writeln( getTextClipBoard() ); //
}
