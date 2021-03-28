import std.stdio;
import std.conv;

void main() {
	immutable string foo = "foo";
	const string bar = "bar";
	string mrX;

	writeln("Please enter 'foo', 'bar', (or some thing):");
	mrX = readln[0..$-1];
	switch (mrX) {
	  case foo:
         writeln("I thought the food was ", foo,"y");
         break;
      case bar:
		 writeln("A kawala walks into a ", bar, " eats, shoots, and leaves!");
         break;
      default:
         writeln("This is outside of my comfort zone (", mrX,")");
   }
}

