enum Colour
{
	RED,
	BLUE
}

template Choice( int i : 1 )
{
	pragma( msg, "Choice: int = first" );
}

template Choice( int i : 2 )
{
	pragma( msg, "Choice: int = second" );
}

template Choice( float f )
{
	pragma( msg, "Choice: float or sink" );
}

template Choice( string s )
{
	pragma( msg,"Choice: s(string) = "~s );
}

void main() {
	alias Choice!(1) A;
	alias Choice!(2) B;
	alias Choice!(3.0) C;
	alias Choice!("Jello, D!") F;
}
