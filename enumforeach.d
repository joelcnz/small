// What dumb
// ng.learn 26 Feb 2011
import std.stdio, std.conv;

enum E { x, y = 10, z = 2, THE_END }


void main()
{
    foreach (e; E.min .. E.max ) { // more for unreset members
        writeln( e );
    }
}
