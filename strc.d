//#not correct total!
import std.stdio;

void main(string[] args) {
//	args~="WINDOWS96"; //WINDOWS96 outputs 666
	foreach( word; args[ 1 .. $ ] ) {
		size_t total;
		import std.algorithm : reduce;
		total = reduce!"a + b"(0, word);
		writefln(`str="%s", chars add up to: %d`, word, total);
	}
}
