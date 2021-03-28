import std.stdio;

enum XYZ : string
{
    A = "hello",
    B = "foo",
    C = "bar"
}

void main()
{
    if (XYZ.A == "hello")
	writeln(XYZ.A); // prints 'A'
    writeln(XYZ.B);
    writeln(XYZ.C);
	
    writeln(cast(string)XYZ.A); // prints 'hello'
    writeln(cast(string)XYZ.B);
    writeln(cast(string)XYZ.C);
}
