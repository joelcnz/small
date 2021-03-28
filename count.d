import std.stdio;

void main( string[] args) {
	string number;
	if ( args.length > 1 )
		number = args[1];
	else {
		writeln( "Correction Ex: count 123 -> one two three" );
	}
	string[char] ns = ['0' : "zero",
		               '1' : "one",
		               '2' : "two",
		               '3' : "three",
		               '4' : "four",
		               '5' : "five",
		               '6' : "six",
		               '7' : "seven",
		               '8' : "eight",
		               '9' : "nine"
		               ];
	foreach( n; number ) {
		write( ns[n], ' ' );
	}
	writeln;
}


