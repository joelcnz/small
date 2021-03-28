//#CountUnilMixin
// Started: Aug 9 2011
//#not know about the name
import
	std.stdio,
	std.string,
	std.ascii,
	std.algorithm;

/+
Idea:
1. Take a line of input and devide it into statements. eg. add"1 2 3" times"1 3" -> 6 and 3
2. Go through each statement and activate them

input: c"house cat "in shed"" add"1 2 3"
output:
house cat "in shed"
6
+/

void main() {
	Parsed parsed;
	string input;
	while( input != "exit" ) {
		input = stripRight( readln() );
		parsed.parse( input );
	}
}

//#dummy is removed in next version of dmd 2.0
bool isNumberQuoteEtc( dchar chr, dchar dummy ) {
	if ( isDigit( chr ) )
		return true;
	foreach( dchar c; `.-+"` )
		if ( chr == c )
			return true;
	return false;
}

struct Parsed { //#not know about the name
	string m_type;
	int[] m_nums;
	void parse( string input ) {
		input = stripRight( input );
		m_type = getType( input );
		writeln( m_type );
	}

	string getType( string input ) {
		dchar dummy = '\0';
		auto indexEnd = countUntil!( isNumberQuoteEtc )( input, dummy );

		if ( indexEnd == -1 ) indexEnd = input.length;
		return input[ 0 .. indexEnd ];
	}
}
