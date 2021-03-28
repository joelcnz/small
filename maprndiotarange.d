//Org bearophile May 24 under 'map kinds of rangers' in d.D
import std.stdio: writeln;
import std.algorithm: sort, map;
import std.math: abs;
import std.range: iota, front, array;
import std.random: uniform;

int gen(int x) { return uniform(-100, 100); } //#what's with the 'int x'

void main() {
    auto data = map!gen(iota(10)).array;
    writeln(data); // just a debug print
//    int result = sort!((a, b){ return abs(a) < abs(b); })(data).front();
	int result = sort!"abs(a) < abs(b)"(data).front;
	writeln(sort!"abs(a) < abs(b)"(data));
    writeln(result);
}
