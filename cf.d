import std.stdio;
import std.process;

void main(string[] args) {
	if (args.length == 1) {
		writeln("Missing main source file Eg. './cf sums'");
		return;
	}
	
	import std.process;

	string miscRoot = "../JMiscLib/source/jmisc/";
	auto dmdPid = spawnProcess(["dmd", args[1], miscRoot ~ "base.d", miscRoot ~ "day.d",
		miscRoot ~ "dayman.d", miscRoot ~ "trig.d", miscRoot ~ "package.d", miscRoot ~ "wildcard.d",
			miscRoot ~= "protime.d",
		"./arsdterminal.d"]);
	if (wait(dmdPid) != 0)
	    writeln("Compilation failed!");
}
