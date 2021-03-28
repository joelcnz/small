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
		foreach(l; m_lines) {
			foreach(n; 0 .. l.number)
				write(l.chr);
		}
		writeln();
	}
}

void main() {
	foreach(part; [iota(0, 6, 2), iota(2, -1, -2)])
		foreach(n; part) {
			Line([Part(' ', 2 - (n+1) / 2), Part('*', n + 1), Part('|', 2 - (n+1)/2)]).print;
		}
		
//	foreach(n; [iota(1,3), iota(2, 1, -1)])
//		writeln(" ".replicate())
}
