// from the dlang home page File("dlang.d") added (replacing 'stdin', which I couldn't get to work)
// Sort lines
import std.stdio;
import std.array;
import std.algorithm;

void main()
{
    File("dlang.d")
        .byLine(KeepTerminator.yes)
        .map!(a => a.idup)
        .array
        .sort
        .copy(
            stdout.lockingTextWriter());
}

