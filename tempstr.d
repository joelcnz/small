import std.stdio;

template greet(string s) {
	auto foo() { return s ~ " Alan"; }
}

template greet2( string s )
{
	auto greet2() { return s ~ " Alan"; }
}

void main()
{
	writeln(greet!"Hello".foo);
	writeln(greet2!"Hello");
}