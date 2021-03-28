void main(string[] args) {
	import std.stdio, std.conv, std.string;

	import std.file;
	File filein;
	if (args.length == 2)
		filein = File(args[1]);
	else
		filein = stdin;
	int n, total;
	while((n = filein.readln.chomp.to!int) != 42) {
		writeln(n);
		total += n;
	}
	writeln("Total: ", total);
}
