// Computes average line length for standard input.
import std.stdio;
import std.range;
import std.conv;
import std.string;

void main(string[] args) {
	writeln("Enter `q` to quit");
	writeln("Enter one word per line:");
    ulong lines = 0;
    double sumLength = 0;
    foreach (line; stdin.byLine()) {
		if (line.length && line[0] == 'q')
			break;
		writeln(line = line.removechars(".,"), //removeExtraBits,
				'-'.repeat(12 - line.length),
				line.length);
        ++lines;
        sumLength += line.length;
	}
    writefln("Average line length: %.2f",
        lines ? sumLength / lines : 0);
}
