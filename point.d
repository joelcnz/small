import std.array;

struct Point(T) {
	T x, y;

	this(T[] f...) {
		assert(f.length == 2);
		x = f[0];
		y = f[1];
	}

	void opAssign(Point!T o) {
		x = o.x;
		y = o.y;
	}

	auto opBinary(string op)(Point!T o) if (op == "+" || op == "*" || (op == "~" && is(T == string))) {
		static if (is(T == string)) {
			switch(op) {
				case "~":
					x ~= o.x;
					y ~= o.y;
				break;
				default:
				break;
			}
		} else {
			mixin("x "~op~"= o.x;");
			mixin("y "~op~"= o.y;");
			/+
			switch(op) {
				case "+":
					x += o.x;
					y += o.y;
				break;
				case "*":
					x *= o.x;
					y *= o.y;
				break;
				default:
				break;
			}
			+/
		}

		return this;
	}

	auto toString() {
		import std.conv;
		return text([x, y]);
	}
}

version(Testing) {
void main() {
	{
		import std.stdio;
		alias Point!int Pint;
		auto p = Pint(5,5);
		writeln("Add: ", p, p + Pint(5,5));
		auto x = Pint(15,15);
		writeln(p, x);
		
		writeln("Times: ", p * Pint(2, 3), p * x, "\n");
		p = Pint(4, 1979);
		x = p;
		writeln("Assign: ", p, x);
	}
	
	{
		import std.stdio;
		alias Point!float Pfloat;
		writeln();
		auto p = Pfloat(5.2,5.2);
		writeln(p, p + Pfloat(4.8,4.8));
		auto x = Pfloat(1.2,1.2);
		writeln(p, x);
		p = Pfloat(4.30, 1979);
		x = p;
		writeln(p, x);
	}

	{
		import std.stdio;
		writeln();
		auto p = Point!string("cat dog".split);
		writeln(p, p ~ Point!string("pig goat".split));
		auto x = Point!string("sofa TV".split);
		writeln(p, x);
		p = Point!string("age body".split);
		x = p;
		writeln(p, x);
	}
}
} // version testing
