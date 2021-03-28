import std;

void main(string[] args)
{
    args[1].File.byLine(Yes.keepTerminator)
           .map!(l => [l.byCodePoint.walkLength, l.splitter.walkLength])
           .fold!((o, l) => [o[0]+1, o[1]+l[1], o[2]+l[0]])([0uL, 0, 0])
           .writefln!"%(%u %) %s"(args[1]);
}
