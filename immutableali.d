// http://ddili.org/ders/d.en/function_parameters.html

import std.stdio;

dchar[] mix(immutable dchar[] first,
            immutable dchar[] second) {
    dchar[] result;
    int i;

    for (i = 0; (i < first.length) && (i < second.length); ++i) {
        result ~= first[i];
        result ~= second[i];
    }

    result ~= first[i..$];
    result ~= second[i..$];

    return result;
}

void main() {
	immutable hello = "HELLO"d;
	auto world = "world"d;
    writeln(mix(hello, world));
}
