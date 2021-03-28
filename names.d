// Org from D artical: http://hawkins.io/2015/04/excited-about-d/
void main() {

	import std.stdio, std.algorithm;

	auto names = [ "Adam Hawkins", "Peter Esselius" ];
	// Become Svensk with a lambda!
	auto swedishNames = names.map!(n => n ~ "son");

	foreach(name; swedishNames) {
		writeln(name);
	}
}
