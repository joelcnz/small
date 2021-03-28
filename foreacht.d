import std.stdio;

void main() {
	auto x = 0f;
	foreach (y; 0.1 .. 100f) {
		x += 0.1;
		writeln(y, ' ', x);
	}
}
