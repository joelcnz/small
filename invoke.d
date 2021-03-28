// From: dlang.org (Invoke external programs)

void main(string[] args)
{
	import std;
	
	if (args.length == 1)
		args ~= "hellow.d";
    import std.exception, std.stdio, std.process;

	writeln("Executable program I used, was this one compiled:");
	wait(spawnProcess(["cat", args[1]]));
    auto result = ["./" ~ args[1].replace(".d", "")].execute;
    enforce(result.status == 0);
//    result.output.write;
	
	import core.thread;
	foreach(c; result.output) {
		Thread.sleep(15.dur!"msecs");
		write(c);
		stdout.flush;
	}
}
