// This is odd
import std.stdio;

void main() {
	writeln("q[Enter] to quit");
	bool done = false;
	char c;
	while(!done) {
		c=cast(char)getchar;
		if (c == 'q')
			done = true;
		else
			write(c);
	}
}
