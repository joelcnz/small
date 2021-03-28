import std.stdio;
import std.conv;
import std.datetime;

void main() {
	int a;
	void f0() {}
	void f1() {auto b = a;}
	void f2() {auto b = to!(string)(a);}
	auto r = benchmark!(f0, f1, f2)(10_000_000);
//	writeln( typeid( r ) );
	printResult( r );
}

void printResult( TickDuration[] r ) { // core.time.TickDuration[]
	foreach( i, a; r )
		writefln("Milliseconds to call fun[%s] n times: %s", i, a.to!("msecs", int));
}
