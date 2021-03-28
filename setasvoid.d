@system:
import std.stdio;
import std.algorithm;

version = Fault;

class Transmogrifier
{
    double[37] alpha;
    size_t usedAlpha; // unused, hey! Look what's that-> (at the top of the source code)? Nothing, just doing random stuff (or trying to)
    
    this()
    {
		alpha[]=7; // fill all of the array with 7's
    }
}

void main()
{
    auto t = new Transmogrifier;
    writeln(t.alpha); 
	int a = void;
	double b = void;
	writeln("a=void => ", a, " double b=void =>", b);
	ubyte[] p; // = void;
	p.length = 100;
	writeln("Start");
	import std.random, std.range;
	p = p.map!((a) => cast(ubyte)uniform(0, 80 + 1)).array;
	p.sort!((a, b) => a < b);
	for(auto c=0; c < p.length; c++) {
		version (Fault) {
			int size = p[c];
			foreach (h; 0 .. size)
				write("#");
			writeln();
		} else {
			writef("%02s ", p[c] % 100); // works
		}
	}
	writeln("End");
}

