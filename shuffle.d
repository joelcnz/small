void main() {
    import std.stdio : writeln;
    import std.random : randomShuffle;

    int[] a = [0,1,2,3,4];
    foreach(_; 0 .. 20) {
        a.randomShuffle;
        writeln(a);
    }
}
