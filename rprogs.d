// What a donkey!
import std.stdio, std.process, std.file, std.conv;

void main() {
	int upto = readText("upto.txt").to!int();
	
	auto exe_files = dirEntries(".", SpanMode.shallow);
	int i = 0;
	foreach(string exe; exe_files) {
		exe = exe[2..$];
		writeln("File: ", exe);
		if (i >= upto) {
			bool doExe = true;
			foreach(c; exe)
				if (c == '.')
					doExe = false;
			if (doExe) {
				system("./"~exe);
				File("upto.txt", "w").write(upto++);
				writeln("Type 'quit' to get out, and enter for next program");
				if (readln()[0] == 'q')
					goto L1;
			}
		}
		i++;
	}
	L1: {
	}
}
