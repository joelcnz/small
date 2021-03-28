import std.stdio;

void main() {
	char a, b;
	a=255;
	b=255;
	
	int d = a + b;
	writeln( d, " ", a + b, "\n char: 255 + 1 = ", cast(ubyte)(a+1) );
}
