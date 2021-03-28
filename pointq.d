module point;

import std.stdio;
import std.conv;

struct Point {
	double x, y, z; //probably float though

	Point opBinary(string s, T)(T other) if (s == "+" || s == "-" || s == "/" || s == "*" || s == "~") {
		static if (s == "~") {
			writeln("In opBinary under ~");
			static typeof(x) append(typeof(x) n, typeof(x) o) {
				int depth = 1;
				double x = n;
				do {
					depth++;
					if (x > 0)
						x /= 10;
				} while(x >= 10);
				if (depth > 0)
					n = n * (10 ^^ depth) + o;
				return n;
			}
			
			return Point(append(x, other.x), append(y, other.y), append(z, other.z));
		}
		else
			return Point(mixin("x" ~ s ~ "other.x"), mixin("y" ~ s ~ "other.y"), mixin("z" ~ s ~ "other.z"));
	}
	
	Point opUnary(string s)() if (s == "~") {
			return Point(z, x, y);
	}

	int opEquals(ref const Point r) const {
		writeln("in opEquals function");
		return x == r.x && y == r.y && z == r.z;
	}

	string toString() {
		return text([x, y, z]);
	}

	unittest {
		auto half = Point(0.5, 0.5, 0.5);
		auto twoFold = Point(2, 2, 2);
		Point p1, p2;
		p1=Point(9,99,999);
		p2=Point(1,1,1);
		writeln(p1, " + ", p2);
		writeln(p1 + p2, " or ", p2+p1);
		writeln(p1, " - ", p2);
		writeln(p1 - p2);
		writeln(p2, " - ", p1);
		writeln(p2 - p1);
		p1=Point(10, 25, 5);
		p2=Point(2, 5, 2);
		writeln(p1, ` / `, p2);
		writeln(p1 / p2);
		writeln(p1, ` * `, p2);
		writeln(p1 * p2);
		writeln(p1, " * half");
		writeln(p1 * half);
		writeln(p1, " * two fold");
		writeln(p1 * twoFold);
		writeln("Point(1,1,1) == Point(1,1,1)");
		writeln(Point(1,1,1) == Point(1,1,1));
		writeln("Point(2,2,2) == Point(1,1,1)");
		writeln(Point(2,2,2) == Point(1,1,1));
		p1 = Point(1,23,456);
		p2 = Point(23,45,789);
		writeln(p1, " -\n", p2, "\np1 ~ p2=", p1~p2);
		writeln("Rotations (rotate = ~rotate):");
		auto rotate = ~Point(2,3,1);
		import std.datetime;
		StopWatch sw;
		sw.start();
		for(;;) {
			if (sw.peek().msecs > 1_000/3) {
				sw.start();
				write(rotate, "\r"); stdout.flush();
				rotate = ~rotate;
			}
		}
	}
}
