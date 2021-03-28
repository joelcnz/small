import std.stdio;

void main() {
	write("[");
	foreach_reverse(f; 0 .. 10)
		write(f,(f==0 ? "" : ", "));
	write("]");
	writeln();
	foreach(f; 0 .. 10)
		write(f,(f==9 ? "" : ", "));
	writeln();
	
	import std.range;
	writeln(iota(10));
}
