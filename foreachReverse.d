//#foreach_reverse may be removed. And I know some one that doesn't like it
import std.stdio;

void main() {
	foreach_reverse( a; "123" )
		a.write;
	stdout.flush(); // redundant, helps me remember though
	'\n'.write;
}
