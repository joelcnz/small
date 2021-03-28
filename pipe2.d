//not working!

void main() {
	import std.process, std.stdio;
	auto info = pipeProcess("./c");
	scope(exit) wait(info.pid);
	info.stdin.writeln("data to send to the process");
	info.stdin.close();
	foreach(line; stdout.byLine)
	     writeln("Received ", line, " from child.");
}
