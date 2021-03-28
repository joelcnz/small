void main() {
	import std.format, std.stdio; 
	
	auto s = format!"%s is %s"("Pi", 3.14);
	assert(s == "Pi is 3.14");
	writefln!"%c is %s"('e', 1.61);

	static assert(!__traits(compiles, {s = format!"%l"();}));     // missing arg
	static assert(!__traits(compiles, {s = format!""(404);}));    // surplus arg
	static assert(!__traits(compiles, {s = format!"%d"(4.03);})); // incompatible arg
}