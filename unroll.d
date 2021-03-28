struct Foo {
    int x, y;
    long a, b, c;
    short i, j, k;
}

enum Which {
    x, y, a, b, c, i, j, k,
}

void assignValue(ref Foo q, Which member, short e) {
    import std.traits : EnumMembers;
    import std.conv : to;

    final switch(member) {
        // foreach over a tuple is unrolled at compile time
        foreach(w; EnumMembers!Which) {
            case w:
                // expands to: q.x, q.y, ...
                mixin("q." ~ w.to!string) = e;
                break;
        }
    }
}

void main() {
    import std.stdio : writeln;
    Foo q;
    writeln("before: ", q);
    assignValue(q, Which.a, 42);
	assignValue(q, Which.x, 1); // see above
    writeln("after: ", q);
}
