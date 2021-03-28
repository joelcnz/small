// enumerate
void main(string[] args)
{
    import std.stdio;
    import std.range;

    bool[int] aa = [0:true, 1:true, 2:false];

    writeln("Get keys and values from an AA");
    foreach (key, value ; aa) {
        writeln(key, ": ", value);
    }
    writeln;

    writeln("Get a counter and the key of an AA");
    foreach (count, key ; aa.byKey.enumerate) {
        writeln("count: ", count, " key: ", key, " value: ", aa[key]);
    }
}
