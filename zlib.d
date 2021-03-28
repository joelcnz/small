import std.stdio;
import std.string: join;
import std.conv;
import std.zlib;

void main(string[] args) {
	string data;
	if (args.length == 1)
		data = "All teshe ppeloe taht go aruond mkaing sanp dsenioics. "
		  "Yu'od think tehy had all tshee tihn sitcks.";
	else
		data = args[1 .. $].join(" ");
//		foreach(word; args[1..$])
//			data ~= word ~ ' ';

	writeln("Orginal: \n", data, '\n');
	auto voidCompressedData=compress(data);
	writeln("compressed:\n'", to!string(voidCompressedData), "'\n");

	auto voidUncompressedData=uncompress(cast(void[])voidCompressedData);
	writeln("Back to uncompressed:\n'", to!string(voidUncompressedData), "\'\n");
}
