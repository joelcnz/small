string bar()
{
	import std.string;
  return format("s=%05X", 80);
}

int k()
{
  int u = 42, n = 5;
  n--;
  u /= n;
  return u;
}

void main() {
	import std.stdio;
	writeln(bar, '\n', k());
}
