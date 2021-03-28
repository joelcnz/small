import std.stdio;

void main() {
	int total;
	foreach(number; [-3,-2,-1,0,1,2,3,4] ) //0 .. 3)
	{
		writeln(number,". Hello Rachael!");
		total += number;
	}
	
	writeln("Total: ", total);
}

