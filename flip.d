import std.stdio;

int add(int sum, int x, int y)
{
	return x+y;
}

class Num {
	int num() {
		return 1;
	}
}

void main() {
	int num, num2;
	num2.add(3,7).writeln; // not work, so what does work? Arrays -- update: works now.
	writeln(num);
}
