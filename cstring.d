//#here we are!
import std.stdio;
import std.c.string;
import std.conv;

void main() {
	auto cstr = cast(char*)"Apartment"; // automaticly adds a null charater
	writeln(cstr.cStringToD);
	writeln(cstr.to!string); //#here we are!
}

string cStringToD( char *cstr ) {
	return cast(string)cstr[0 .. strlen( cstr ) ];
}
