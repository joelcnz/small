import std.stdio : writeln, stdin, stdout;
import std.range : enumerate;

void main() {
	writeln("Enter text:");
    foreach (lineNum, line; stdin.byLine().enumerate(1))
        stdout.writefln("line #%s: %s", lineNum, line);
}
