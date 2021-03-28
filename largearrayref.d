// Org from ng.learn 1 Mar 5:07am - Dr.Smith
//# real multi-dim does not work - ?
import std.stdio;
import std.conv;

void main() {
	int[string] data;
	auto data2 = new int[][](200, 1_000); // row, collum

	for(int i = 0; i < data2[0].length; i++) { // collom
		for(int j = 0; j < data2.length; j++) { // row

		  // fake multi-dim works
		  string str = to!string(i) ~ "," ~ to!string(j);
		  data[str] = i * j;

		  data2[j][i] = i * j;
		}
	}
	
	writeln("3,7 = ", data["3,7"]);
	writeln("3,7 = ", data2[3][7]);
	
	writeln("999,199 = ", data["999,199"]);
}
