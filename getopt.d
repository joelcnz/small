// Big crash for a little misstake
import std.stdio;
import std.getopt;

int main(string[] args)
{
	// Opt variables
	string myString;
	bool verboseFlag = false;
	
	getopt(args,
		"s|myString", &myString, // -s or --myString
		"verboseFlag", &verboseFlag); // -- verbosesFlag=[...]
	
	writeln("myString: ", myString);
	writeln("verboseFlag: ", verboseFlag);
	
	writeln("args left: ", args);
	
	// Print help
	if (result.helpWanted)
		defaultGetoptPrinter("Help:", result.options);
	
	return 0;
}
