import std.stdio;

void main() {
	foreach(int n; 1 .. 10 + 1) {
		writeln(n, " Jeremy");
	}
	writeln("You cross the finish like! Well done!");
}

/+
void main()
{
	int lap;
	lap = 1;
	while(lap <= 10)
	{
		writefln("Lap %s", lap);
		lap = lap + 1;
	}
	writeln("You cross the finish like! Well done!");
}
+/