module main;

import std.stdio;
import std.conv;

void main(string[] args)
{
	try {
	    // Prints "Hello World" string in console
	    writeln("Hello World!");
		"a".to!int; // planted here on purpose
	} catch (Exception e) {
		writeln("Exception caught"); // this worked
	}
    
    // Lets the user press <Return> before program returns
    stdin.readln();
}
