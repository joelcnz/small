//Note - unittest
import std.stdio;
import std.string;

void mainq() {
	test;
	import std : indexOf;
	size_t n = "asdf".indexOf("#");
	writeln("size_t: n = ", n);
	if (n == -1)
		writeln("n == -1");
}

unittest {
	test; // rem out when doing unittest's
}

void test() {
	string delegate ( string ) sound;
	string cat( string strsound ) { return "Cat sound " ~ strsound; }
	string dog( string strsound ) { return "Dog sound " ~ strsound; }
	
	sound = &cat;
	writeln( sound( "Meow!" ) );
	sound = &dog;
	writeln( sound( "bark!" ) );
	
	writeln(); //--------------------
	
	foreach( i, s; [ &cat, &dog ] )
		writeln( s( [ "Meow!", "Bark!" ][i] ) ); // picks ~'meow' then on the second iteration it does ~'bark'

	int y=2;
	auto add_y = (int x) { return x+y; };
	writeln( add_y(8) ); // 10 - delegate, not function
	
	writeln();
	auto str = "I went for a walk".split();
	alphaNumbers(str, (i, s) => writeln(i, ' ', s));
	alphaNumbers(str, (i, s) => writefln("%d%5s", i, s));

	writeln();
	auto alpNum = (int i, string s) => writeln(i, ' ', s);
	void function(int, string) alpNum2 = (i, s) => writefln("%d%5s", i, s);
	alphaNumbers(str, alpNum);
	alphaNumbers(str, alpNum2);
}

void alphaNumbers(string[] strs, void function(int, string) dg) {
	foreach(i, s; strs) {
		dg(cast(int)i, s);
	}
}

