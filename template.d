import std.stdio;

template foo(string s)
{
    string bar() { return s ~ " betty"; }
}

string tem(string s)() {
	return s ~ " Betty";
}

auto add(alias num, alias num2)() 
	if (is(typeof(num) == int) && is(typeof(num2)))
{
	num++;
	num2++;
	return num + num2;
}

void main()
{
	writefln("%s", foo!("hello").bar()); // prints: hello betty
	writefln("%s", tem!"hello"); // prints: hello betty

	int x = 10, y = 5;
	writeln("before: ", [x, y]);
	writeln("Add: ", x, " + ", y, " = ", add!(x, y)());
	writeln("after: ", [x, y]);
	
	auto input = readln;
	writeln("Hello ", input);
//	add('c', 1); // see below
/+
template.d(32): Error: template template.add cannot deduce function from argument types !()(char, int), candidates are:
template.d(12):        template.add(alias num, alias num2)() if (is(typeof(num) == int) && is(typeof(num2)))
Failed: ["dmd", "-v", "-o-", "template.d", "-I."]
+/
}
