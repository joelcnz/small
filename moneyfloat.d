void main() {
    float money = 0.0;
    foreach(_; 0 .. 10_000) {
        import std.stdio;

        writeln("$", money);
        money += 0.01;
    }
}