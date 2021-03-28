// Enter: 'factory String'

import std.stdio;

class String {
	string str = "Where's the party at?";
}

void main(string[] args) {
	if ( args.length == 1 ) {
		writeln("Enter: 'factory String'");
		return;
	}

	auto obj1 = Object.factory("object.Object");
	assert(obj1);

	auto obj2 = cast(String)Object.factory("factory." ~ args[1]);
	if ( obj2 is null )
		writeln(args[1] ~ " failed");
	else
		writeln(obj2.str);
}
