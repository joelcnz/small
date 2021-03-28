// universal function common (?) systax
import ufcs4c, ufcs4b;

void main() {
	auto maths = new Maths!int;
	
	import std.stdio;
	writeln(maths.plus(3, 7).value);
	writeln(maths.minus(10, 3).value);
	writeln(maths.value);
}
