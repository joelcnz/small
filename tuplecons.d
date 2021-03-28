//#From d.learn 2 June 2012
import std.stdio;
import std.typecons;
 
struct Foo {}
 
Tuple!(int, string, Foo) baz() {
    // some computation here
    // ..
    return tuple(13, "inches", Foo());
}
 
void main() {
    auto bar = baz();
    assert(bar == tuple(13, "inches", Foo()));
    foreach( e; bar.expand )
		writeln( typeid( typeof( e ) ), ": ", e );
	more();
	auto doAdd = add(0);
	assert(doAdd.expand[0] + doAdd.expand[1] == 0);
	doAdd = add(7);
	assert(doAdd.expand[0] + doAdd.expand[1] == 7);
	
	assert(add(7).expand[0] + add(7).expand[1] == 7);
}

Tuple!(int, int) add(int x) {
	if (x == 7)
		return tuple(3, 4);
	else
		return tuple(0, 0);
}

//#From d.learn 2 June 2012
import std.stdio;
//import std.typecons;
import std.typetuple;

template TypeAndName(Variables...)
{
   static if (Variables.length == 0)
       alias TypeTuple!() TypeAndName;
   else
       alias TypeTuple!(typeof(Variables[0]), Variables[0].stringof,
TypeAndName!(Variables[1..$])) TypeAndName;
}

Tuple!(TypeAndName!(Variables)) toTuple(Variables...)() @property
{
   return Tuple!(TypeAndName!(Variables))(Variables);
}

void more()
{
   int i = 1;
   double d = 3.14;
   auto t = toTuple!(i,d);
   writeln(t.i);
   writeln(t.d);
}
