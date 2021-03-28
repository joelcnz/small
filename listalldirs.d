// eg cmdln: listalldirs "rem list dirs" "copy listalldirs.d " "" ":exit"
// after the second parameter the directory is inserted (listalldirs "rem remark" "cp listalldirs.d " "" ":exit"
// doesnt include the current directory
import std.stdio;
import std.file;
import std.process;

string[] args;

void main(string[] args1) {
	args = args1;
	bool justTest = false, okDoIt = true;
	process(justTest);
	writeln("Do it, yes?");
	if (readln == "yes\n") {
		writeln("Ok, doing it!");
		process(okDoIt);
	}
}

void sys(in string s) {
	wait(spawnShell(s));
}

void process(bool doIt = false) {
	writeln("Note: outputs to z.bat copies previous to zq.bat\n");
	//system("del z.bat");
	if (doIt)
		sys("mv z.bat zq.bat"));
	foreach(a; 0 .. 4)
		args ~= "";
	args = args[1 .. $];
	writeProcess(args[0], doIt);
	foreach(string dir; dirEntries(".", SpanMode.depth)) {
		if (dir.isDir)
			writeProcess(args[1] ~ dir[2 .. $] ~ args[2], doIt);
	}
	writeProcess(args[3], doIt);
}

void writeProcess(string cmd, bool doForReal) {
	writeln(cmd);
	if (doForReal)
		append("z.bat", cmd ~ '\n');
}

/+
void main(string[] args) {
	//* - each dir
	string result;
	result 
}
+/
