import std.stdio;
import std.process;
import core.thread;

void main() {
	auto frame = [["###",
		       "# #",
		       "###"],
		      ["   ",
		       " # ",
		       "   "]];
	bool done = false;
	while(! done) {
		foreach(f; frame) {
			foreach(l; f) {
				writeln(l);
			}
			Thread.sleep(500.msecs); //dur!"msecs"(500));
			system("clear");
		}
	}
}
