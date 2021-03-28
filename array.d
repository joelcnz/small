bool[320][240] map; // true hit

static this() {
	foreach(y; 0 .. 240)
		map[y][] = true;
}

unittest {
	assert(map[239][319] == true);
	import std.stdio: writeln;
	writeln("All, 1 test, passed");
}
