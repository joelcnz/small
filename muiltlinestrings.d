//Org: Small problem with multi-line strings d.D.Learn -- andrej.mitrovich@gmail.com
import std.stdio;

void main() {
writeln(q"EOS
- First item:  150
- Second item: 200
- Third item:  105
EOS"[ 0 .. $ - 1]);

writeln("#");

//what about this
writeln("
- First item:  150
- Second item: 200
- Third item:  105
"[ 1 .. $ - 1 ] );
writeln("#");
}
