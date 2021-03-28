import std.stdio;

void main()
{
	int lap;
	lap = 1;
	while(lap <= 10)
	{
		writefln("Lap %s", lap);
		lap = lap + 1;
	}
	writeln("You cross the finish line! Well done!");
}
