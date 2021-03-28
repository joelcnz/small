import std.stdio;

struct Thing {
	string str = "unassigned";
	auto opAssign( string str0 )
	{
		str = str0;

		return this;
	}
	string opCall()
	{
		return str;
	}
}

void main() {
	Thing t, t2;
	void update() {
		writeln( t(), " and ", t2());
	}
	update;
	t = t2 = "Assigned";
	update;
}
