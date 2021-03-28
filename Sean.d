import std.stdio;

void main() {
	writeln("Sean!");
	foreach(sharks; 1 .. 10 + 1) {
		if (sharks == 5) {
			writeln("Five sharks!");
		} else {
			writeln(sharks, " - shark", sharks > 1 ? "s" : "");
		}
	}
}
