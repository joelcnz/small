import std.range : isInputRange;
import std.array;

template TypeTupleOf(TL...)
    if (TL.length == 1 && isInputRange!(typeof(TL[0])))
{
    import std.typetuple : TT = TypeTuple;
    enum r = TL[0];
    static if (r.empty)
        alias TypeTupleOf = TT!();
    else
    {
        enum f = r.front;
        alias TypeTupleOf = TT!(
            f,
            TypeTupleOf!(
                { auto tmp = r; tmp.popFront(); return tmp; }()
                )
            );
    }
}

unittest
{
    import std.range : iota;
    foreach(i; TypeTupleOf!(iota(10)))
    {
        pragma(msg, i);
    }
}
