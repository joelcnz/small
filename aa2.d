//#just numbers
// unfinished
void main() {
	auto list = ["Joel" : 35, "Alan" : 38, "Timothy" : 32];
	import std.stdio: writeln;
	writeln(list);
	
	foreach(e; list) //#just numbers
		writeln(e);
	foreach(e; list.keys)
		writeln(e);
}

string list(T)(T[S]) {
}
