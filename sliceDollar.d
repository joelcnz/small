// Org: Ali Çehreli 
// opSlice() or opIndex() for the entire slice?
// http://forum.dlang.org/thread/luadir$t0g$1@digitalmars.com
import std.stdio;

struct Collection
{
    int[] elements;

    /* Handles the slice operations */
    struct Slice
    {
        int[] slice;

        Slice opAssign(int value)
        {
            writefln("Slice.opAssign(int)");
            slice[] = value;
            return this;
        }
    }

    size_t opDollar() const
    {
        writefln("opDollar()");
        return elements.length;
    }

    // CHALLENGE: Can you replace this with an opSlice overload?
    Slice opIndex()
    {
        writefln("opIndex()");
        return Slice(elements);
    }

    Slice opSlice(size_t dim, A...)(A args)
    {
        writefln("opSlice!%s(%(%s, %))", dim, [ args ]);
        return Slice(elements[args[0] .. args[1]]);
    }

    Collection opIndexAssign(A...)(int value, A indexes)
    {
        writefln("opIndexAssign(%s, %(%s, %))", value, [ indexes ]);

        foreach (dim, x; indexes)
        {
            static if (is(typeof(x) : size_t))
            {
                elements[x] = value;

            } else static if (is(typeof(x) : Slice)) {
                x = value;

            } else {
                static assert(false);
            }
        }

        return this;
    }
}

void main()
{
    auto c = Collection([ 0, 1, 2, 3]);

    writeln("\n--- c[] ---");
    c[];

    writeln("\n--- c[1 .. $-1] = 42 ---");
    c[1 .. $-1] = 42;

    writeln("\n--- c[3] = 100 ---");
    c[3] = 100;

    assert(c.elements == [ 0, 42, 42, 100 ]);
	writeln("c.elements == [ 0, 42, 42, 100 ]");
}

/+

--- c[] ---
opIndex()

--- c[1 .. $-1] = 42 ---
opDollar()
opSlice!0(1, 3)
opIndexAssign(42, Slice([1, 2]))
Slice.opAssign(int)

--- c[3] = 100 ---
opIndexAssign(100, 3)
+/
