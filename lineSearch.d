// Colour Theme on TextMate - mac classic
void main(string[] args) {
    import std.range: popFront;
    args.popFront; // remove executable

    if (args.length < 2) {
        import std.stdio: writeln;

        writeln("E.g. ./lineSearch money.ini cost");

        return;
    }

    import std.stdio: File, writeln;
    import std.string: join, indexOf;
    import std.algorithm: filter, canFind, each;
    import std.conv: to;

    immutable fileName = args[0];
    immutable phrase = args[1 .. $].join(" "); // make a phrase (with more than one word)

    File(fileName, "r").byLine
    .filter!((a) => a.canFind( phrase ))
    .each!writeln;
}