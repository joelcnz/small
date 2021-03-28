void main() {
	import std.string;
	import std.stdio;
	auto var = split("I went for a walk and fell down a hole!");
	auto var2 = "I went for a walk and fell down a  hole!".split;

	auto lines = var.join("\n");
	
	writeln(lines);

	import std.algorithm : each;
	var2.each!(a => writeln(a));
}
