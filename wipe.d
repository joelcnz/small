string bar()
{
	import std.string;
  return format("s=%05X", 80);
}

void main() {
	import std.stdio;
	writeln(bar);
}
