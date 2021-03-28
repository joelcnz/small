void main() {
	import std.stdio;

    string list = q"IDENT
1. Item One
2. Item Two
3. Item Three
IDENT";
    writeln('*', list, '*');

	auto list2="
1. one
2. two
"[1..$-1];
	write('*', list2, '*');
}
