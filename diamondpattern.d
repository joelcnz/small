import std.stdio;
import std.range;

struct Part {
	char chr;
	int number;
}

struct Line {	
	Part[3] m_lines;
	
	this(Part[3] lines) {
		m_lines = lines;
	}
	
	void print() {
		foreach(l; m_lines)
			foreach(n; 0 .. l.number)
				write(l.chr);
		writeln();
	}
}

void main() {
	version(fail) {
		int size = 5,
			leftRight = size,
			middle = 1;
	
		assert( leftRight > 0 &&
				middle == 1);
		auto pattern = chain(iota(0, size, 2), iota(size, 0, -2)).array;
	
		foreach(line; 0 .. 5) {
			writeln(' '.repeat.take(leftRight), '*'.repeat.take(pattern[line + 1]), ' '.repeat.take(leftRight));
			leftRight--;
			middle += 2;
		}
	} // version fail
	
	foreach(part; [iota(0, 6, 2), iota(2, -1, -2)]) {
		foreach(n; part) {
			Line([Part(' ', 2 - (n + 1) / 2), Part('*', n + 1), Part('|', 2 - (n + 1) / 2 )]).print;
		}
	}
}
