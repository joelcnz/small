import std.stdio;
import std.string;
import core.stdc.string;
import core.stdc.stdio;
import std.conv: to;

void main() {
	immutable hello = "Hello"; // '\0' is added automatically at the end
	writeln(hello[0 .. strlen(hello.ptr)]);
	
	printf("<%s>\n", hello.dup.ptr);
	
	auto cstr = cast(char*)"What's this?";
	//char* cstr = "What's this?".dup.ptr;
	writeln(cstr.to!string); //#this works, thanks to Jonathan M Davis
	
	char[50] str;
	strcpy(str.ptr, "house".ptr);
	writeln(strcat(str.ptr, " cat.".toStringz).to!string);
}
