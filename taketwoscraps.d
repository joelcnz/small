// See taketwo.d
import std.stdio, std.string, std.conv, std.ascii, std.array;

//version=Older;
//version=Newer;
version=EvenNewer;

const usage = `if (args.length == 1) {
		writeln("No, like this: Eg. ./taketwo FAKE MOUSE");
		return;
	}`;

void main(string[] args) {
	version(EvenNewer) {
		mixin(usage);
		immutable(ulong)[immutable(char)] tiles = [
			'A' : 1,
			'B' : 3,
			'C' : 3,
			'D' : 2,
			'E' : 1,
			'F' : 4,
			'G' : 2,
			'H' : 4,
			'I' : 1,
			'J' : 8,
			'K' : 5,
			'L' : 1,
			'M' : 3,
			'N' : 1,
			'O' : 1,
			'P' : 3,
			'Q' : 10,
			'R' : 1,
			'S' : 1,
			'T' : 1,
			'U' : 1,
			'V' : 4,
			'W' : 4,
			'X' : 8,
			'Y' : 4,
			'Z' : 10,
			];

		ulong total = 0;
		foreach(l; join(args[1..$])) {
			char t = l;
			t = cast(char)toUpper(t);
			if (t in tiles)
				total += tiles[t];
		}
		writeln("Total: ", total);
	}
	version(Newer) {
		mixin(usage);
		ulong[string] tile;
		tile["A"]=1;
		tile["B"]=3;
		tile["C"]=3;
		tile["D"]=2;
		tile["E"]=1;
		tile["F"]=4;
		tile["G"]=2;
		tile["H"]=4;
		tile["I"]=1;
		tile["J"]=8;
		tile["K"]=5;
		tile["L"]=1;
		tile["M"]=3;
		tile["N"]=1;
		tile["O"]=1;
		tile["P"]=3;
		tile["Q"]=10;
		tile["R"]=1;
		tile["S"]=1;
		tile["T"]=1;
		tile["U"]=1;
		tile["V"]=4;
		tile["W"]=4;
		tile["X"]=8;
		tile["Y"]=4;
		tile["Z"]=10;

		ulong total;
		string chrs;
		foreach(arg; args[1..$]) 
			chrs ~= arg;
		foreach(input; chrs) {
			string key=to!string(toUpper(input));
			if (key in tile)
				total+=tile[key];
		}
		writeln("Total: ", total);
	}
	version(Older) {
		int total;
		foreach(n; args[1..$])
			total+=to!int(n);
		writeln("Total: ", total);
	}
}

