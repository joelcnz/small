#!rdmd
import std.string, std.conv, std.ascii, std.array;

/+
Joel Ezra Christensen - 40 nice number, I was in mental hospital the first time for that many days (I worked out, the number of days, in my head)
Alan Katherine - 20
Alan Christensen - 20
Timothy Christensen - 31 (found this at the time of him being 31)
Katherine - 16
Christensen - 16
+/

alias Tiles = int[char]; // map value (key and value -- name[key] = value;
Tiles tiles;

void main(string[] args) {
	version(unittest) {
	} else {
		if (process(args = args[1 .. $])) {
			getDoTiles(args);
		}
	}
}

auto process(string[] args) {
	const none = 0;
	if (args.length == none) {
		import std.stdio: writeln;

		writeln("No.. like this: Eg. `./taketwo FAKE MOUSE -JQV`");
		return false;
	}

	return true;
}

auto getDoTiles(in string[] args) {
	tiles = getProcessData;

	import std.stdio: writeln;

	auto total = 0;
	writeln("Total: ", total = getProcessLettersTotal(args, tiles));

	return total;
}

auto getProcessLettersTotal(in string[] args, in Tiles tiles) {
	int total = 0;
	bool minus = false;
	foreach(t; args.join.toUpper) {
		switch(t) {
			default: /+ continue +/ break;
			case 'A': .. case 'Z':
				final switch(minus) {
					case false: total += tiles[t]; break;
					case true:  total -= tiles[t]; break;
				}
				break;
			case '-': minus = true; break;
			case '+': minus = false; break;	
		}
	}

	return total;
}

auto getProcessData() {
	import std.algorithm: each;

	"A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".
	split.
	each!(d => tiles[d[0]] = d[1 .. $].to!int);

	return tiles;
}

unittest {
	import std.stdio: writeln;
	import std.string: split;

	writeln(getDoTiles("katherine - christensen".split));
	assert(getDoTiles("katherine - christensen".split) == 0);
	assert(getDoTiles("katherine -christensen".split) == 0);
}
