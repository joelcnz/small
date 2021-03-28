import std.stdio, std.algorithm;

static int idx;

void walk(R)(R range) {
    while (!range.empty) {
        range.front;
        range.popFront;
        ++idx;
    }
}

void main() {
    [4, 30, 1979].map!(a => [a].writeln).walk;
}
