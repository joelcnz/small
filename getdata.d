import std.stdio;
import std.file;

void main() {
	immutable fileName = "data.txt";
	foreach(line; File(fileName, "r").byLine)
		writeln("<", line, ">");
}
