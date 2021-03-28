// Forum: https://forum.dlang.org/post/qmrmybeqzznynhrmbeza@forum.dlang.org
// use time ./splitter #
import std.stdio : writeln, write;
import std.algorithm : canFind, splitter, filter;
import std.string : split;

void main(string[] args) {
	if (args.length == 1) {
		writeln("abc,:def;ghi". // or "abc, def. Ghi"
			splitter!(a => " .,:;".canFind(a)).
			filter!(a => a.length));
		return;
	}

	if (args[1] == "1") {
		foreach(t; 0 .. 1_000_000)
			//writeln("1) ",
				"abc,:def;ghi". // or "abc, def. Ghi"
				splitter!(a => " .,:;".canFind(a)).
				filter!(a => a.length); //);
	}

//This is much slower:
	if (args[1] == "2") {
		auto s = "abc,,,..  :def;;:,,;,ghi".dup;
		foreach(t; 0 .. 1_000_000) {
			foreach(ref a; s) {
				if (".,;: ".canFind(a)) {
					a = ' ';
				}
			}
			s.split;
		}
	}
}
