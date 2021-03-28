import std.stdio: writeln, write;

void main() {
	writeln(typeid(string));
	foreach( c; "Intercity")
		write( c ~ " ");
	writeln;

	import std.string: join;
	import std.algorithm: map;
	writeln("Intercity".map!((a) => a ~ " "d).join);
}
