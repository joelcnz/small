// from ng learn
// don't know the point, think it doesn't work
// arrays are different than in the C language
import std.stdio;

void main() {
	auto arr = [1,2,3];
	auto pa = arr.ptr;
	writeln((*pa));
	writeln((*pa)+1);
	writeln((*pa)+2);
	
	writeln( arr.ptr[3] ); // no bounds check
}
