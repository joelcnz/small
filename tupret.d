import std.stdio;
import std.typecons: Tuple, tuple;

version = Ver1;

void main() {
	version( Ver1 ) {
		Tuple!( int, int ) getAB() {
			return tuple(5, 3);
		}
		
		auto ab = getAB;
		
		writeln( ab[0], ' ', ab[1] );
	}
}
