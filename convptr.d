//#this is new
import std.stdio;
import std.conv;
import std.string;

void main() {
	//auto ptr = "Hello".dup.ptr; // AKA 'char*'
	char* pointer;
	pointer = "Hello".dup.ptr;
	auto normal = "Hi ya";
	writeln(); // to put the next out put with the ones following
	writeln( typeid( typeof ( pointer ) ) );
	writeln( to!string( pointer ) );
	
	typeof( pointer ) test; //#this is new
	test = "How are you?".dup.ptr;
	writefln(
		"test: (%s) %s",
		typeid( typeof ( pointer ) ),
		test.to!string, // can't put to!char[]( test ), - see next line
		test.to!(char[])); // can't put to!char[]( test ); //see next line
		
}
