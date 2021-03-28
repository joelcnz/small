import std.stdio;

struct Widget {
    private int[] array;
    this(uint length) {
        array = new int[length];
        writefln("ctor called      : %s", array.ptr);
    }
    this(this) {
        writef( "this(this) called: %s", array.ptr );
        array = array.dup;
        writefln(" -> %s", array.ptr);
    }
}

void main() {
    auto w1 = Widget(10);
    writeln(w1);
}
