//#this is better
//#fail, does not stay the at 3 for example
// What does the statement '@property' do, ever? Some thing to do with the '()'s
import std.stdio, std.string;


class Number {
	private int _num, _num2, m_num;

	@property
	ref auto num() { return _num; }
	
	@property
	ref auto num2( int value ) {
		writeln( "start value: ", _num2 );
		if ( value < 0 )
			_num2 = 0;
		else if ( value > 3  )
			_num2 = 3;
		writeln( "end value: ", _num2 ); //#fail, does not stay the at 3 for example
		return _num2;
	}
	@property
	auto num2() { return _num2; }
	
	//#this is better
	@property
	auto num3() { return m_num; }
	@property
	auto num3( int num ) { return m_num = currentRule( num ); }
	
	int delegate ( int ) currentRule;

	void setSwitch( int slot ) {
		currentRule = [ &rule1, &rule2 ][ slot ];
		writeln( ruleType( slot ) );
	}
	
	auto ruleType( int index ) {
		return "Rule: " ~ "Zero rather than a negitive number|Make negitive number positive".split( "|" )[ index ];
	}
	
	/// Zero rather than a negitive number
	int rule1( int value ) {
		if ( value < 0 )
			return 0;

		return value;
	}

	/// make negitive number positive
	int rule2( int value ) {
		if ( value < 0 )
			return value *= -1;

		return value;
	}
}

void main() {
	auto number = new Number;
	/+
	number.num += 5;
	assert( number.num == 5 );
	number.num -= 2;
	assert( number.num == 3 );
	number.num2( number.num2 ) = 0;
	number.num2( number.num2 )++;
	assert( number.num2 == 1 );
	number.num2( number.num2 + 50 ) += 50;
	writeln( number.num2 );
	//assert( number.num2 == 53 ); // Hmm.. now this is crazy, prints 53 but is not equal to 53?!
	+/
	
	immutable doTry = "writeln( `Try num3  =  -10` );";
	immutable doResult = "writeln( `result num3 = `, num3 );";
	writeln( typeid( typeof( doTry ) ) );
	writeln( typeid( doResult ) );
	with( number ) {
		setSwitch( 0 );
		num3 = 50;
		assert( num3 == 50 );
		num3 = num3 + 4;
		assert( num3 == 54 );

		mixin( doTry );
		num3 = -10;
		mixin( doResult );
		assert( num3 == 0 );
		setSwitch( 1 );
		mixin( doTry );
		num3 = -10;
		mixin( doResult );
		assert( num3 == 10 );
	}
	
	writeln( "All tests passed!" );
}
