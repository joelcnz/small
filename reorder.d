R tap(alias pred, R)(R r) @trusted {
	import std.algorithm, std.array;
	r.map!((a) => pred(a)).array;

	return r;
}

void main(string[] args) {
	import std.stdio;
	if (args.length != 3) {
		version(Windows)
			immutable ifMac = "";
		else
			immutable ifMac = "./";
		writeln("Eg. ", ifMac, "order alerts.ini alarm");
		return;
	}
	
	import std.file;
	if (! args[1].exists) {
		writeln([args[1]], " File not found!");
		return;
	}
	
	import std.algorithm;
	import std.conv;
	int id;
	string output;
	foreach(line; File(args[1]).byLine) {
		if (line.startsWith("[" ~ args[2]))
			line = text("[", args[2], id++, "]").to!(char[]);
		output ~= line ~ "\n"; 
	}
		
	File(args[1], "w").write(output);
	if (! id) {
		writeln(args[2], " section name not found, here are your options:");

		dstring[] possibles;
		auto checkForBraketGetLettersAddWord(dstring line) {
			if (line.length
				&&
				line[0] == '[') {
				import std.ascii, std.string, std.array;
				possibles ~= line.filter!((a) => letters.indexOf(a) != -1).array;
				
				return ""d;
			}
			return ""d;
		}
		
		File(args[1]).byLine.tap!((line) => checkForBraketGetLettersAddWord(line.to!dstring)).to!dstring;

		possibles.sort!"a < b".uniq.each!writeln;
	} else {
		writeln(id, " section count");
	}
}
