//#not sure about inPattern, it works differently than I though
import std.stdio, std.string, std.ascii, std.algorithm, std.functional;

void main() {
	string a = " \n  Hello, world!";
	assert( find!( not!isWhite )( a ) == "Hello, world!" );
	doCountUntil();
	mixinCountUntil();
	doCount();
	writeln( "all tests passed, yay!" );
}

bool isNumber( dchar chr, dchar dummy ) {
    return  ( ( chr >= '0' && chr <= '9' ) || chr == '.'  || chr == '-' || chr == '+' || chr == '"' );
}

void doCountUntil() {
    dchar dummy = '\0';
    auto input = "abc1234";
    auto indexEnd = countUntil!( isANumber )( input, dummy );
    assert( indexEnd == 3 );
}

bool isANumber( dchar chr, dchar dummy ) {
	if ( isDigit( chr ) == true )
		return true;
	
	foreach( dchar c; `"-+.` )
		if ( chr == c )
			return true;
	return false;
}

bool isANum( dchar chr ) {
	return inPattern( chr, `0-9"+-.` );
}

void doCount() {
    auto input = `ab1c-123de34fghi+j`;
    auto total = 0L;

	total = count!(not!isNum)(input);
    assert( total == 10 );

	total = count!( not!isANum )( input );
    assert( total == 10 );

	//#not sure about inPattern, it works differently than I though
	total = count!( ( a ) { return !inPattern( a, digits ~ `"+-.` ); } )( input );
    assert( total == 10 );
}

immutable isNum = `(a >= '0' && a <= '9' ) || a == '"' || a == '.' || a == '-' || a == '+'`;

immutable indexOfFirstNumber =
	`indexEnd = countUntil!( ( chr, b ) {
		return ( ( chr >= '0' && chr <= '9' ) || chr == '.' || chr == '-' || chr == '+' ||
			chr == '"' );
	} )( input, '\0' );`;

void mixinCountUntil() {
	long indexEnd = -1;
	auto input = "abcd123"; //abc123 is a poor test
	mixin( indexOfFirstNumber );
	assert( indexEnd == 4 );
	input = "def";
	mixin( indexOfFirstNumber );
	assert( indexEnd == -1 );
}
