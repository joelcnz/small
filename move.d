import std.stdio;
import core.thread;
import std.process;

void main() {
	auto frame =
[
 ["###",
  " # ",
  "## ",
  "###"],
 ["   ",
  "###",
  " # ",
  "###"],
 ["   ",
  "   ",
  "###",
  "###"],
 ["   ",
  "   ",
  "   ",
  "###"],
 ["   ",
  "   ",
  "###",
  "###"],
 ["   ",
  "###",
  " # ",
  "###"],
 ["###",
  " # ",
  "## ",
  "###"],
];

	bool done = false;
	while(! done) {
		foreach(f; frame) {
			foreach(l; f) {
				writeln(l);
			}
			Thread.sleep(dur!"msecs"(200));
			version(OSX) {
				system("clear");
			} else version(Windows) {
				system("cls");
			}
		}
	}
}
