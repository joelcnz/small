// See: rangereducedotdotdotdelegateclosureslazy.d
import std.stdio;

void doTimes(lazy void start, int count, void delegate() exp, lazy void end) {
	start();
	foreach(c; 0..count)
		exp();
	end();
}

void main() {
	int x = 0;
	doTimes(write("Start-"), 10, { write(x++); x < 10 && write("-"); }, writeln("-End"));
}
