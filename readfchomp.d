//#I was thinking of putting this in the learn forum
//#not work?
//Org: Ali - writing a tutorial for D2
//Dates: 23 6 11, 3 9 2016

version(all) {
import std.stdio;
import std.string;
import std.math;

T trag(T)( T o ) {
	static if ( is( typeof( o ) == string ) ) {
		o = toUpper( o );
	}
	else
		o /= 2;
	return o;
}

void main()
{
	writeln( trag!string( "yell!" ) );
	writeln( trag!int( 30 ) );
	
    float MyFloat1, MyFloat2;
	write( "Enter 2 floats: " ); stdout.flush;
	getUserInput(MyFloat1, MyFloat2);
	
    writeln( MyFloat1 + MyFloat2 );

    int MyInt1, MyInt2;
	write( "Enter 2 ints: " ); stdout.flush;
	getUserInput(MyInt1, MyInt2);
    writeln( MyInt1 + MyInt2 );

	//#problem here
	write( "Enter a string: " ); stdout.flush;
    string MyString = readln.chomp; //#not work?
    writeln( MyString );
}

void getUserInput(T)(out T num1, out T num2) {
	try {
		readf(" %s %s\n", &num1, &num2 );
	} catch(Exception e) {
		writeln("Invalid input!");
		return;
	}
}
} // version

version(none) {
//#I was thinking of putting this in the learn forum
import std.stdio : writeln, readf, readln;
import std.string : chomp;

void main() {
	int num;
	writeln("Enter a number:");
	readf(" %s\n", &num);
	
	writeln( "Enter a string:" );
	string
		MyString;
	MyString = readln.chomp;
	writeln( MyString );
}
} // version