import std.stdio;

void printPosition(float x, float y, float z) {
	writeln( x, " ", y, " ", z );
}

struct Point {
	float x; float y; float z;
}

void main() {
	Point currentPos = {1,2,3};
	
	printPosition(currentPos.tupleof); // A
	
	//A is equivalent to typing out: // B
	printPosition( currentPos.x, currentPos.y, currentPos.z );
	
	writeln( currentPos.tupleof.stringof );
	writeln( typeid( currentPos.tupleof ) );
}
