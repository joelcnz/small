import std.stdio, std.conv;

void main( string[] args ) {
	int a = to!int( args[ 1 ] );
	int n = ( a + 4 ) / 5 ;
	alias writeln putchar;
	switch ( a % 5 )
	{
	  case 0: do
			  {
				putchar ( '5' ) ;
	  case 4:   putchar ( '4' ) ;
	  case 3:   putchar ( '3' ) ;
	  case 2:   putchar ( '2' ) ;
	  case 1:   putchar ( '1' ) ;
			  } while ( --n ) ;
	default: break;
	}
}
